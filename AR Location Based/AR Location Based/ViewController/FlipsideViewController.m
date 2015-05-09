//
//  FlipsideViewController.m
//  AR Location Based
//
//  Created by Jhonathan Wyterlin on 09/05/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction methods

-(IBAction)done:(id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end