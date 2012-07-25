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

@synthesize album, titleField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Load the title
    titleField.text = self.album.title;
    
    // Load the coverflow
    CGRect cfViewFrame = coverFlowView.frame;
    cfViewFrame.origin = CGPointMake(0, 0);
    coverFlowSubView = [[STRCoverFlowView alloc] initWithFrame:cfViewFrame];
    [coverFlowSubView loadAlbumCovers:[[STRAlbumObjectManager defaultManager] allAlbumCoverNames]];
    [coverFlowView addSubview:coverFlowSubView];
    
    // Update the coverflow to the proper album cover
    NSString * coverArtName = self.album.coverArt;
    NSLog(@"STRAlbumPreferencesViewController: Displaying album cover art: %@", coverArtName);
    NSUInteger index = [[coverFlowSubView albums] indexOfObject:coverArtName];
    NSLog(@"STRAlbumPreferencesViewController: Requesting the display of album at index: %i", index);
    [coverFlowSubView scrollToIndex:index];
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
    NSError * error;
    [[STRAlbumObjectManager defaultManager] saveTitle:titleField.text andCoverArt:[[coverFlowSubView albums] objectAtIndex:[coverFlowSubView arrayIndexForSelectedAlbum]] changesToAlbum:self.album error:&error];
    if (error) {
        NSLog(@"STRAlbumPreferencesViewController: !!!ERROR: There was an error saving changes to your album.");
    }
    // Dismiss the view controller
    NSLog(@"STRPreferencesViewController: Dismissing preferences view contoller");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancelButtonWasPressed:(id)sender {
    NSLog(@"STRPreferencesViewController: Dismissing preferences view controller without saving.");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
