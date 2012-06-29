//
//  STRUserPreferencesManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/21/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRUserPreferencesManager.h"

@interface STRUserPreferencesManager (InternalMethods)

-(User *)theUser;

@end

@implementation STRUserPreferencesManager {
    
}

+(STRUserPreferencesManager *)preferencesForCurrentUser {
#warning Incomplete implementation - not dynamic
    return [[STRUserPreferencesManager alloc] init];
}

-(CLLocationAccuracy)desiredLocationAccuracy {
#warning Incomplete implementation - hardcoded return value
    return kCLLocationAccuracyBestForNavigation;
}

@end

@implementation STRUserPreferencesManager (InternalMethods)

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

@end
