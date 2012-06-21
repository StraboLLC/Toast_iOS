//
//  STRGalleryTabController.m
//  Toast
//
//  Created by Thomas Beatty on 6/20/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRGalleryTabController.h"

@interface STRGalleryTabController (InternalMethods)

-(void)shouldTransitionFromViewController:(UIViewController *)sourceViewController toViewController:(UIViewController *)destinationViewController;

@end

@implementation STRGalleryTabController

@synthesize album, captureManager;
@synthesize mapGalleryViewController, tileGalleryViewController;

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
	NSLog(@"STRGalleryTabController: Tab controller did load. Setting up the child views.");
    // Set up the child views
    self.mapGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapGalleryViewController"];
    self.tileGalleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tileGalleryViewController"];
    self.mapGalleryViewController.view.frame = containerView.frame;
    self.tileGalleryViewController.view.frame = containerView.frame;
    
    [self addChildViewController:self.mapGalleryViewController];
    [self addChildViewController:self.tileGalleryViewController];
    
    [containerView addSubview:self.mapGalleryViewController.view];
    [containerView addSubview:self.tileGalleryViewController.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.captureManager logAllAssociatedCaptures];
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

-(IBAction)backButtonWasPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)mapTabButtonWasPressed:(id)sender {
    [self shouldTransitionFromViewController:self.tileGalleryViewController toViewController:self.mapGalleryViewController];
}

-(IBAction)tileTabButtonWasPressed:(id)sender {
    [self shouldTransitionFromViewController:self.mapGalleryViewController toViewController:self.tileGalleryViewController];
}

@end

@implementation STRGalleryTabController (InternalMethods)

-(void)shouldTransitionFromViewController:(UIViewController *)sourceViewController toViewController:(UIViewController *)destinationViewController {
    [self transitionFromViewController:sourceViewController 
                      toViewController:destinationViewController 
                              duration:0.0 
                               options:UIViewAnimationTransitionNone 
                            animations:^{} 
                            completion:nil];
}

@end
