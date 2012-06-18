//
//  STRAlbumsViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/13/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRAlbumsViewController.h"
#import "STRAppDelegate.h"

@interface STRAlbumsViewController (InternalMethods)

-(NSArray *)getAllAlbumsForUser:(NSNumber *)userID;

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
    // Fetch the current user's userID
    NSNumber * currentUserID = [[[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] currentUser] userID];
    NSArray * allAlbums = [self getAllAlbumsForUser:currentUserID];
    #warning Incomplete implementation
    // Present the albums on the screen
    NSLog(@"Saved Albums: %@", allAlbums);
    
}

#pragma mark - Button Handling

@end

@implementation STRAlbumsViewController (InternalMethods)

-(NSArray *)getAllAlbumsForUser:(NSNumber *)userID {
    // Returns an array of a user's albums sorted by date created
    // Get pointers to the object context
    STRAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = [appDelegate managedObjectContext];
    
    // Set up the request
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    //[request setSortDescriptors:sortDescriptors];
    
    // Execute the request
    NSError * error;
    User * user = [[context executeFetchRequest:request error:&error] objectAtIndex:0];    
    if (error) {
        NSLog(@"STRAlbumViewController: !!!Error occurred while trying to fetch user: %@", error);
        return nil;
    } else {
        // Get the user's albums
        NSSet * allAlbums = user.albums;
        NSLog(@"STRAlbumViewController: Fetched %i albums for user %i successfully.", allAlbums.count, userID.intValue);
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        return [[allAlbums allObjects] sortedArrayUsingDescriptors:sortDescriptors];;
    }
}

@end