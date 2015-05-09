//
//  FlipsideViewController.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "FlipsideViewController.h"

// Third party
#import "ARKit.h"

// Model
#import "Place.h"

// Service Layer
#import "MarkerView.h"
#import "PlacesLoader.h"

@interface FlipsideViewController ()<ARLocationDelegate, ARDelegate, ARMarkerDelegate, MarkerViewDelegate>

@property(nonatomic,strong) AugmentedRealityController *arController;
@property(nonatomic,strong) NSMutableArray *geoLocations;

@end

NSString *const kPhoneKey = @"formatted_phone_number";
NSString *const kWebsiteKey = @"website";

const int kInfoViewTag = 1001;

@implementation FlipsideViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupARController];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self geoLocations];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction methods

-(IBAction)done:(id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

#pragma mark - ARDelegate methods

-(void)didUpdateHeading:(CLHeading *)newHeading {
    
}

-(void)didUpdateLocation:(CLLocation *)newLocation {
    
}

-(void)didUpdateOrientation:(UIDeviceOrientation)orientation {
    
}

#pragma mark - ARMarkerDelegate methods

-(void)didTapMarker:(ARGeoCoordinate *)coordinate {
}

#pragma mark - ARLocationDelegate methods

-(NSMutableArray *)geoLocations {

    if ( ! _geoLocations)
        [self generateGeoLocations];

    return _geoLocations;

}

-(void)locationClicked:(ARGeoCoordinate *) coordinate {
}

#pragma mark - MarkerViewDelegate methods

-(void)didTouchMarkerView:(MarkerView *)markerView {
    
    ARGeoCoordinate *tappedCoordinate = markerView.coordinate;
    CLLocation *location = tappedCoordinate.geoLocation;
    
    int index = (int)[self.locations indexOfObjectPassingTest:^(Place *place, NSUInteger index, BOOL *stop) {
        return [place.location isEqual:location];
    }];
    
    if ( index != NSNotFound ) {

        Place *tappedPlace = self.locations[index];
        
        [[PlacesLoader sharedInstance] loadDetailInformation:tappedPlace successHanlder:^(NSDictionary *response) {

            NSDictionary *resultDict = response[@"result"];
            
            tappedPlace.phoneNumber = resultDict[kPhoneKey];
            tappedPlace.website = resultDict[kWebsiteKey];

            [self showInfoViewForPlace:tappedPlace];
            
        } errorHandler:^(NSError *error) {
            NSLog( @"Error: %@", error );
        }];
        
    }
    
}

#pragma mark - Touch Event methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UIView *infoView = [self.view viewWithTag:kInfoViewTag];

    [infoView removeFromSuperview];

}

#pragma mark - Private methods

-(void)setupARController {

    if ( ! self.arController )
        self.arController = [[AugmentedRealityController alloc] initWithView:self.view parentViewController:self withDelgate:self];

    self.arController.minimumScaleFactor = 0.5;
    self.arController.scaleViewsBasedOnDistance = YES;
    self.arController.rotateViewsBasedOnPerspective = YES;
    self.arController.debugMode = NO;

}

-(void)generateGeoLocations {

    self.geoLocations = [NSMutableArray arrayWithCapacity:self.locations.count];
    
    for ( Place *place in self.locations ) {

        ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:place.location locationTitle:place.placeName];

        [coordinate calibrateUsingOrigin:self.userLocation.location];
        
        MarkerView *markerView = [[MarkerView alloc] initWithCoordinate:coordinate delegate:self];
        [coordinate setDisplayView:markerView];
        
        [self.arController addCoordinate:coordinate];
        [self.geoLocations addObject:coordinate];
        
    }
    
}

-(void)showInfoViewForPlace:(Place *)place {

    CGRect frame = self.view.frame;
    CGRect frameInfoView = CGRectMake(50.0f, 50.0f, frame.size.width - 100.0f, frame.size.height - 100.0f);

    UITextView *infoView = [[UITextView alloc] initWithFrame:frameInfoView];
    infoView.center = self.view.center;
    infoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    infoView.text = place.infoText;
    infoView.tag = kInfoViewTag;
    infoView.editable = NO;

    [self.view addSubview:infoView];

}

@end