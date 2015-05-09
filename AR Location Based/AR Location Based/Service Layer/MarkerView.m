//
//  MarkerView.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "MarkerView.h"

// Third party
#import "ARGeoCoordinate.h"

@interface MarkerView ()

@property(nonatomic,strong) UILabel *distanceLabel;

@end

const float kWidth = 200.0f;
const float kHeight = 100.0f;

@implementation MarkerView

-(id)initWithCoordinate:(ARGeoCoordinate *)coordinate delegate:(id<MarkerViewDelegate>)delegate {

    CGRect frame = CGRectMake(0.0f, 0.0f, kWidth, kHeight);
    
    if ( ( self = [super initWithFrame:frame] ) ) {
        
        self.coordinate = coordinate;
        self.delegate = delegate;
        
        self.userInteractionEnabled = YES;

        CGRect titleFrame = CGRectMake(0.0f, 0.0f, kWidth, 40.0f);
        
        UILabel *title = [[UILabel alloc] initWithFrame:titleFrame];
        title.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.7f];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = coordinate.title;
        [title sizeToFit];
        
        CGRect distanceFrame = CGRectMake(0.0f, 45.0f, kWidth, 40.0f);
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:distanceFrame];
        self.distanceLabel.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.7f];
        self.distanceLabel.textColor = [UIColor whiteColor];
        self.distanceLabel.textAlignment = NSTextAlignmentCenter;
        self.distanceLabel.text = [NSString stringWithFormat:@"%.2f km", coordinate.distanceFromOrigin / 1000.0f];
        [self.distanceLabel sizeToFit];
        
        [self addSubview:title];
        [self addSubview:self.distanceLabel];
        
        [self setBackgroundColor:[UIColor clearColor]];

    }

    return self;

}

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f km", self.coordinate.distanceFromOrigin / 1000.0f];
    
}

@end
