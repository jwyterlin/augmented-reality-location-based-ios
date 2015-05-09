//
//  FlipsideViewController.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "FlipsideViewController.h"

#import <MapKit/MapKit.h>
#import "ARKit.h"

// Model
#import "Place.h"

@interface FlipsideViewController ()<ARLocationDelegate, ARDelegate, ARMarkerDelegate>

@property(nonatomic,strong) NSArray *locations;
@property(nonatomic,strong) MKUserLocation *userLocation;

@property(nonatomic,strong) AugmentedRealityController *arController;
@property(nonatomic,strong) NSMutableArray *geoLocations;

@end

@implementation FlipsideViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupARController];
    
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
    return nil;
}

-(void)locationClicked:(ARGeoCoordinate *) coordinate {
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
        
        // more code later
        
        [self.arController addCoordinate:coordinate];
        [self.geoLocations addObject:coordinate];
        
    }
    
}

@end