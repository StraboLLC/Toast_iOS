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
    
    // Save a new album to core data
    NSError * error;
    [[STRAlbumManager defaultManager] saveNewAlbumWithTitle:titleField.text 
                                                   coverArt:@"Red Moleskine" 
                                                      error:&error];
    // Dismiss this view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

@implementation STRNewAlbumViewController (InternalMethods)

@end
