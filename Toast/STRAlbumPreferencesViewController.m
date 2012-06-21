//
//  STRAlbumPreferencesViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRAlbumPreferencesViewController.h"

@interface STRAlbumPreferencesViewController ()

@end

@implementation STRAlbumPreferencesViewController

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

-(IBAction)submitButtonWasPressed:(id)sender {
    // Save any changed preferences
    
    // Dismiss the view controller
    NSLog(@"STRPreferencesViewController: Dismissing preferences view contoller");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
