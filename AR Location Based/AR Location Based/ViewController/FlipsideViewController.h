//
//  FlipsideViewController.h
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
