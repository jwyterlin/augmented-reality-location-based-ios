//
//  PlaceAnnotation.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"

@interface PlaceAnnotation()

@property(nonatomic,strong) Place *place;

@end

@implementation PlaceAnnotation

-(id)initWithPlace:(Place *)place {
    
    if ( self = [super init] )
        self.place = place;

    return self;
    
}

-(CLLocationCoordinate2D)coordinate {
    return self.place.location.coordinate;
}

-(NSString *)title {
    return self.place.placeName;
}

@end
