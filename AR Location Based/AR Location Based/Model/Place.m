//
//  Place.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Place.h"

@implementation Place

#pragma mark - Public methods

-(id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address {
    
    if ( self = [super init] ) {
        
        self.location = location;
        self.reference = reference;
        self.placeName = name;
        self.address = address;
        
    }
    
    return self;
    
}

@end
