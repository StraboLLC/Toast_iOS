//
//  STRAlbumsViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/13/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRAlbumsViewController.h"
#import "STRAppDelegate.h"

@interface STRAlbumsViewController ()

@end

@interface STRAlbumsViewController (STRCoverFlowViewDelegate) <STRCoverFlowViewDelegate>

-(void)shouldPresentGalleryViewForAlbum:(Album *)album;

@end

@implementation STRAlbumsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    if ([[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] isUserLoggedIn]) {
        [self reloadAlbums];
    }
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 

-(void)reloadAlbums {
    
    // First, remove the old view if necessary
    [coverFlowSubView removeFromSuperview];
    coverFlowSubView = nil;
    
    NSLog(@"STRAlbumViewController: Reloading the current user's albums");
    
    NSArray * allAlbums = [[STRAlbumObjectManager defaultManager] albumsForCurrentUser];
    
    CGRect cfViewFrame = coverFlowView.frame;
    cfViewFrame.origin = CGPointMake(0, 0);
    coverFlowSubView = [[STRCoverFlowView alloc] initWithFrame:cfViewFrame];
    coverFlowSubView.delegate = self;
    [coverFlowSubView loadAlbums:allAlbums];
    [coverFlowView addSubview:coverFlowSubView];
    
}

#pragma mark - Button Handling

@end

@implementation STRAlbumsViewController (STRCoverFlowViewDelegate)

-(void)shouldPresentGalleryViewForAlbum:(Album *)album {
#warning Incomplete implementation - needs to add album to galleryTabController
    NSLog(@"STRAlbumViewController: Should present gallery view for the album: %@", album.title);
    // Create a new gallery view controller **with the given album
    STRGalleryTabController * galleryTabController = [self.storyboard instantiateViewControllerWithIdentifier:@"galleryTabController"];
    // Push the new gallery view controller to the navigator stack
    [self.navigationController pushViewController:galleryTabController animated:YES];
    
}

@end