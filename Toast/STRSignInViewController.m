//
//  STRSignInViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/11/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRSignInViewController.h"

@interface STRSignInViewController ()

@end

@implementation STRSignInViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Handling

-(IBAction)signInButtonWasPressed:(id)sender {
    NSLog(@"Sign In button was pressed.");
}

@end
