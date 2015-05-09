//
//  PlacesLoader.h
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

typedef void (^SuccessHandler)(NSDictionary *responseDict);
typedef void (^ErrorHandler)(NSError *error);

@interface PlacesLoader : NSObject

+(PlacesLoader *)sharedInstance;

-(void)loadPOIsForLocation:(CLLocation *)location
                    radius:(int)radius
            successHandler:(SuccessHandler)handler
              errorHandler:(ErrorHandler)errorHandler;

@end
