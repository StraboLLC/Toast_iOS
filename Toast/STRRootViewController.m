//
//  STRRootViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/13/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRRootViewController.h"

@interface STRRootViewController (InternalMethods)
-(void)presentLoginControllerIfNecessary;
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

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Load the child view controllers
    UINavigationController * albumNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"albumNavigationController"];
    
    // Set up the child view controller
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 0;
    albumNavigationController.view.frame = newFrame;
    albumNavigationController.navigationBar.hidden = YES;
    [self addChildViewController:albumNavigationController];
    [self.view addSubview:albumNavigationController.view];
}

-(void)viewDidAppear:(BOOL)animated {
    [self presentLoginControllerIfNecessary];
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

#pragma mark -

-(void)dismissLoginViewController {
    NSLog(@"STRAlbumViewController: Dismissing presentedViewController.");
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation STRRootViewController (InternalMethods)
-(void)presentLoginControllerIfNecessary {
    if (![[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] isUserLoggedIn]) {
        NSLog(@"STRRootViewController: Presenting the login screen.");
        UINavigationController * loginNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavigationController"];
        loginNavigationController.navigationBar.hidden = YES;
        [self presentViewController:loginNavigationController animated:NO completion:nil];
    }
}
@end
