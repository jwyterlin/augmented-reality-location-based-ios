//
//  MarkerView.h
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARGeoCoordinate;
@protocol MarkerViewDelegate;

@interface MarkerView : UIView

@property (nonatomic,strong) ARGeoCoordinate *coordinate;
@property (nonatomic,weak) id <MarkerViewDelegate> delegate;

-(id)initWithCoordinate:(ARGeoCoordinate *)coordinate delegate:(id<MarkerViewDelegate>)delegate;

@end

@protocol MarkerViewDelegate <NSObject>

-(void)didTouchMarkerView:(MarkerView *)markerView;

@end
