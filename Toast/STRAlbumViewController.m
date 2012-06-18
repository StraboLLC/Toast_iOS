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
    NSLog(@"STRAlbumViewController: Reloading the current user's albums");
    NSArray * allAlbums = [[STRAlbumManager defaultManager] albumsForCurrentUser];
    #warning Incomplete implementation
    // Present the albums on the screen
    NSLog(@"Saved Albums: %@", allAlbums);
    
}

#pragma mark - Button Handling

@end