//
//  PlacesLoader.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "PlacesLoader.h"

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/NSJSONSerialization.h>

// Model
#import "Place.h"

NSString *const apiURL = @"https://maps.googleapis.com/maps/api/place/";
NSString *const apiKey = @"AIzaSyBAydiT1VyV_HbZ1ATzNb2RQw_nDmPypqM";
NSString *const serverKey = @"AIzaSyAN1H-2VZDZ7SEg9_ECoOPR7DFNk9A1VuI";

@interface PlacesLoader()

@property (nonatomic,strong) SuccessHandler successHandler;
@property (nonatomic,strong) ErrorHandler errorHandler;
@property (nonatomic,strong) NSMutableData *responseData;

@end

@implementation PlacesLoader

#pragma mark - Public methods

+(PlacesLoader *)sharedInstance {

    static PlacesLoader *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [PlacesLoader new];
    });
    
    return instance;

}

-(void)loadPOIsForLocation:(CLLocation *)location
                    radius:(int)radius
            successHandler:(SuccessHandler)handler
              errorHandler:(ErrorHandler)errorHandler {

    self.responseData = nil;
    self.successHandler = handler;
    self.errorHandler = errorHandler;
    
    CLLocationDegrees latitude = [location coordinate].latitude;
    CLLocationDegrees longitude = [location coordinate].longitude;
    
    NSMutableString *uri = [NSMutableString stringWithString:apiURL];
    [uri appendString:@"nearbysearch/json?"];
    [uri appendFormat:@"location=%f,%f", latitude, longitude];
    [uri appendFormat:@"&radius=%d", radius];
    [uri appendFormat:@"&sensor=true"];
    [uri appendFormat:@"&types=establishment"];
    [uri appendFormat:@"&key=%@", serverKey];

    NSString *urlString = [uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    double intervalInSeconds = 20.0;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:intervalInSeconds];
    
    [request setHTTPShouldHandleCookies:YES];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSLog(@"Starting connection: %@ for request: %@", connection, request);
    
}

-(void)loadDetailInformation:(Place *)location
              successHanlder:(SuccessHandler)handler
                errorHandler:(ErrorHandler)errorHandler {

    self.responseData = nil;
    self.successHandler = handler;
    self.errorHandler = errorHandler;

    NSMutableString *uri = [NSMutableString stringWithString:apiURL];
    [uri appendString:@"details/json?"];
    [uri appendFormat:@"reference=%@", location.reference];
    [uri appendString:@"&sensor=true"];
    [uri appendFormat:@"&key=%@", serverKey];

    NSString *urlString = [uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:urlString];

    double intervalInSeconds = 20.0;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:intervalInSeconds];

    [request setHTTPShouldHandleCookies:YES];
    [request setHTTPMethod:@"GET"];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    NSLog( @"Starting connection: %@ for request: %@", connection, request );

}

#pragma mark - NSURLConnectionDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    if ( ! self.responseData )
        self.responseData = [NSMutableData dataWithData:data];
    else
        [self.responseData appendData:data];

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    id object = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:nil];
    
    if ( self.successHandler )
        self.successHandler(object);

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if ( self.errorHandler )
        self.errorHandler( error );

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}

@end
