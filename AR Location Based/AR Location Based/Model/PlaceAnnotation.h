//
//  PlaceAnnotation.h
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject<MKAnnotation>

-(id)initWithPlace:(Place *)place;
-(CLLocationCoordinate2D)coordinate;
-(NSString *)title;

@end
