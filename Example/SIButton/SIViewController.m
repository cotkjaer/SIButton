//
//  SIViewController.m
//  SIButton
//
//  Created by christian otkjær on 02/06/2015.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import "SIViewController.h"

@interface SIViewController ()

@end

@implementation SIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)siButtonPressed:(UIControl *)sender
{
    sender.selected = !sender.isSelected;
    
    NSLog(@"Pressing Button");
}

@end
