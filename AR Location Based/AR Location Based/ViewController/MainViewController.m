//
//  ViewController.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "MainViewController.h"
#import "FlipsideViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

// Service Layer
#import "PlacesLoader.h"

@interface MainViewController ()<FlipsideViewControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic,strong) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) IBOutlet UIButton *cameraButton;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

const double MAX_DISTANCE_ACCURACY_IN_METERS = 100.0;

@implementation MainViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cameraButton.layer.cornerRadius = 5.0;
    
    [self setupLocationManager];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - FlipsideViewControllerDelegate methods

-(void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Prepare for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [[segue identifier] isEqualToString:@"showAlternate"] )
        [[segue destinationViewController] setDelegate:self];
    
}

#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation *newestLocation = [locations lastObject];

    CLLocationAccuracy accuracy = [newestLocation horizontalAccuracy];

    if ( accuracy < MAX_DISTANCE_ACCURACY_IN_METERS ) {

        MKCoordinateSpan span = MKCoordinateSpanMake( 0.14, 0.14 );
        MKCoordinateRegion region = MKCoordinateRegionMake( [newestLocation coordinate], span );

        [self.mapView setRegion:region animated:YES];
        
        int radiusInMeters = 1000;

        [[PlacesLoader sharedInstance] loadPOIsForLocation:[locations lastObject] radius:radiusInMeters successHandler:^(NSDictionary *response) {

            NSLog( @"Response: %@", response );

            // More code here

        } errorHandler:^(NSError *error) {

            NSLog( @"Error: %@", error );

        }];

        // Stop to save battery life
        [manager stopUpdatingLocation];

    }

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog( @"locationManager: didFailWithError: %@", error );
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSLog( @"didChangeAuthorizationStatus: %i", status );
    
    // To use in the future
//    self.gpsDenied = ( status == kCLAuthorizationStatusDenied );
    
}

#pragma mark - Private methods

-(void)setupLocationManager {
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    if ( [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] )
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
}

@end
