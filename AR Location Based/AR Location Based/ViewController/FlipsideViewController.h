//
//  FlipsideViewController.h
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
-(void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property(weak,nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property(nonatomic,strong) NSArray *locations;
@property(nonatomic,strong) MKUserLocation *userLocation;

-(IBAction)done:(id)sender;

@end
