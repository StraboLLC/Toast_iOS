//
//  STRRootViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/11/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRRootViewController.h"

@interface STRRootViewController ()

@end

@implementation STRRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Load the child view controllers
    loginNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavigationController"];
    
    // Set up the child view controllers
    loginNavigationController.view.frame = self.view.frame;
    loginNavigationController.navigationBar.hidden = YES;
    
    // Load the first child view
    [self.view addSubview:loginNavigationController.view];
    
    // Present the nav controller
    [self presentViewController:loginNavigationController animated:NO completion:NULL];
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

@end
