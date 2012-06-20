//
//  STRNewAlbumViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRNewAlbumViewController.h"

@interface STRNewAlbumViewController (InternalMethods)

@end

@implementation STRNewAlbumViewController

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
	// Do any additional setup after loading the view.
    
    CGRect cfViewFrame = coverFlowView.frame;
    cfViewFrame.origin = CGPointMake(0, 0);
    coverFlowSubView = [[STRCoverFlowView alloc] initWithFrame:cfViewFrame];
    [coverFlowSubView loadAlbumCovers:[[STRAlbumManager defaultManager] allAlbumCoverNames]];
    [coverFlowView addSubview:coverFlowSubView];
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

-(IBAction)cancelButtonWasPressed:(id)sender {
    // Dismiss this view controller without saving a new album object
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)submitButtonWasPressed:(id)sender {
    NSLog(@"STRNewAlbumViewController: Submit button was pressed.");
    // Save a new album to core data
    NSError * error;
    [[STRAlbumManager defaultManager] saveNewAlbumWithTitle:titleField.text 
                                                   coverArt:[[coverFlowSubView albums] objectAtIndex:[coverFlowSubView arrayIndexForSelectedAlbum]]
                                                      error:&error];
    // Dismiss this view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

@implementation STRNewAlbumViewController (InternalMethods)

@end
