//
//  STRAlbumManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/18/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRAlbumObjectManager.h"
#import "STRAppDelegate.h"

/**
 Handles the creation, deletion, editing, and retrieval of albums.
 
 Interfaces with Core Data to handle all aspects of album management.
 
 New STRAlbumObjectManagers can be instantiated and used at any time, but it is recommended that you access the defaultManager as described below instead.
 
 ##Default Manager
 
 Because the STRAlbumObjectManager is accessed by many different objects and methods, it is useful to intantiate only one STRAlbumManager object and keep a pointer to it in the app delegate. defaultManager looks for property albumManager in the app delegate (a STRAppDelegate) and returns the pointer to this object. This way, the album manager that was instantiated at application start can be easily accessed.
 */
@interface STRAlbumObjectManager (InternalMethods)

@end

@implementation STRAlbumObjectManager

+(STRAlbumObjectManager *)defaultManager {
    return [(STRAppDelegate *)[[UIApplication sharedApplication] delegate] albumManager];
}

#pragma mark - Album Cover Handling

-(NSString *)coverPathForCoverArt:(NSString *)coverArt {
    NSURL * coverPath = [NSURL URLWithString:[[[self albumNamesDictionary] allKeysForObject:coverArt] objectAtIndex:0]];
    return [NSString stringWithFormat:@"%@", coverPath];
}

-(NSString *)coverArtForCoverPath:(NSString *)coverPath {
    NSString * albumName = [[self albumNamesDictionary] objectForKey:[NSString stringWithFormat:@"%@", coverPath.lastPathComponent]];
    return albumName;
}

#pragma mark - Utility Methods

-(NSString *)generateUniqueAlbumToken {
    NSNumber * userIDNumber = [[[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] currentUser] userID];
    NSTimeInterval dateNumber = [[NSDate date] timeIntervalSince1970];
    NSString * token = [[NSString stringWithFormat:@"%@%f", userIDNumber, dateNumber] MD5];
    NSLog(@"STRAlbumManager: Unique album token generated: %@", token);
    return token;
}

-(NSDictionary *)albumNamesDictionary {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"album_names" ofType:@"plist"];
    NSLog(@"STRAlbumManager: Generating dictionary of album names and coverart paths from file: %@.", dataPath);
    return [NSDictionary dictionaryWithContentsOfFile:dataPath];
}

-(NSArray *)allAlbumCoverNames {
    NSDictionary * albumDictionary = [self albumNamesDictionary];
    NSMutableArray * albumNameArray = [[NSMutableArray alloc] initWithCapacity:albumDictionary.count];
    NSString * key;
    for (key in albumDictionary) {
        [albumNameArray addObject:[albumDictionary objectForKey:key]];
    }
    return albumNameArray;
}

-(UIImage *)coverImageForCoverWithName:(NSString *)coverArt {
    NSString * coverArtPath = [self coverPathForCoverArt:coverArt];
    UIImage * albumImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[coverArtPath stringByDeletingPathExtension] ofType:[coverArtPath pathExtension]]];
    return albumImage;
}

#pragma mark - Retrieving Objects

-(User *)theUser {
    
    // Get some info pertaining to the current user
    NSNumber * currentUserID = [[[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] currentUser] userID];
    NSManagedObjectContext * context = [(STRAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Set up the request
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID == %@", currentUserID];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    // Execute the request
    NSError * error;
    User * user = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    
    if (error) {
        NSLog(@"STRAlbumManager: !!!Error occurred while trying to fetch user: %@", error);
        return nil;
    } else {
        return user;
    }
}

-(NSArray *)albumsForCurrentUser {
    // Get the user's albums
    NSSet * allAlbums = [[self theUser] albums];
    NSLog(@"STRAlbumManager: Fetched %i albums for user %i successfully.", allAlbums.count, [[[self theUser] userID] intValue]);
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    // Return the albums, sorted according to the above descriptors
    return [[allAlbums allObjects] sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma mark - Saving Objects

-(void)saveNewAlbumWithTitle:(NSString *)title coverArt:(NSString *)coverArt error:(NSError *__autoreleasing *)error {
    NSLog(@"STRAlbumManager: Creating a new album: %@ with cover art:%@", title, coverArt);
    
    NSManagedObjectContext * context = [(STRAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    Album * newAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    newAlbum.title = title;
    newAlbum.token = [self generateUniqueAlbumToken];
    newAlbum.creationDate = [NSDate date];
    newAlbum.coverArt = [NSString stringWithFormat:@"%@", coverArt];
    
    // Save the album to core data
    [[self theUser] addAlbumsObject:newAlbum];
    NSError * newError;
    [context save:&newError];
    if (newError) {
        NSLog(@"STRAlbumManager: !!!Error saving new album to the managed object context: %@", newError);
        *error = newError;
    } else {
        NSLog(@"STRAlbumManager: New album saved successfully to the managed object context.");
    }
}

-(void)saveTitle:(NSString *)title andCoverArt:(NSString *)coverArt changesToAlbum:(Album *)album error:(NSError *__autoreleasing *)error {
    album.title = title;
    album.coverArt = coverArt;
    NSManagedObjectContext * context = [(STRAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSError * newError;
    [context save:&newError];
    if (newError) {
        *error = newError;
    }
}

@end