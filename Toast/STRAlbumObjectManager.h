//
//  STRAlbumManager.h
//  Toast
//
//  Created by Thomas Beatty on 6/18/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+Hash.h"
#import "CoreDataObjects.h"

/**
 Handles the creation, deletion, editing, and retrieval of albums.
 
 Interfaces with Core Data to handle all aspects of album management.
 
 New STRAlbumObjectManagers can be instantiated and used at any time, but it is recommended that you access the defaultManager as described below instead.
 
 ##Default Manager
 
 Because the STRAlbumObjectManager is accessed by many different objects and methods, it is useful to intantiate only one STRAlbumObjectManager object and keep a pointer to it in the app delegate. defaultManager looks for property albumManager in the app delegate (a STRAppDelegate) and returns the pointer to this object. This way, the album manager that was instantiated at application start can be easily accessed.
 */
@interface STRAlbumObjectManager : NSObject

/**
 Accesses the app delegate and obtains the pointer to the AlbumManager
 
 Looks for the property [STRAppDelegate albumManager] in the app delegate and obtains a pointer to that object.
 
 @return The default STRAlbumManager object.
 */
+(STRAlbumObjectManager *)defaultManager;

///---------------------------------------------------------------------------------------
/// @name Handling Album Covers
///---------------------------------------------------------------------------------------

/**
 Matches a URL to the cover image for a given album cover name.
 
 @param coverArt The string which specifies the name of the cover image of the album.
 
 @return The path to the image for the album relative to the main bundle.
 */
-(NSString *)coverPathForCoverArt:(NSString *)coverArt;

/**
 Matches a name (string) to the cover image path of an album.
 
 @param coverPath The path of the cover image of the album. This can either be a path relative to the main bundle or an absolute path.
 
 @return The name of the cover art at the specified path.
 */
-(NSString *)coverArtForCoverPath:(NSURL *)coverPath;


///---------------------------------------------------------------------------------------
/// @name Utility Methods
///---------------------------------------------------------------------------------------

/**
 Returns a token that is saved with each album. 
 
 This value is created from a combination of the user's userID and the current date and time so that it is guaranteed to be unique.
 */
-(NSString *)generateUniqueAlbumToken;

/**
 Returns a dictionary of album names and cover art file names.
 
 @return Dictionary with the contents of album_covers/album_names.plist
 */
-(NSDictionary *)albumNamesDictionary;

/**
 Generates an array of all of the possible cover names.
 
 @return An array of album names with the contents of album_covers/album_names.plist
 */
-(NSArray *)allAlbumCoverNames;

/**
 Returns a UIImage with the album cover associated with the cover art string.
 
 @param coverArt The name of the album cover as noted in the album_names.plist file.
 
 @return UIImage A UIImage representation of the cover art.
 */
-(UIImage *)coverImageForCoverWithName:(NSString *)coverArt;

///---------------------------------------------------------------------------------------
/// @name Retrieving Objects From Core Data
///---------------------------------------------------------------------------------------

/**
 Gets the core data object associated with the current user.
 
 @return User object from core data that is associated with the current user.
 */
-(User *)theUser;

/**
 Returns an array of all of the current user's albums.
 
 @return An array containing all of the albums that belong to the current user. The albums in the array are ordered by date taken.
 */
-(NSArray *)albumsForCurrentUser;

///---------------------------------------------------------------------------------------
/// @name Saving Objects to Core Data
///---------------------------------------------------------------------------------------

/**
 Save a new album to Core Data
 
 Creates a new album with the specified title and cover art and saves it to the core data stack.
 
 @param title The user-defined title of the album.
 
 @param coverArt The name of the cover art that should be represented on the album
 
 @param error Any errors that may occur while processing the Managed Object Context request.
 */
-(void)saveNewAlbumWithTitle:(NSString *)title coverArt:(NSString *)coverArt error:(NSError *__autoreleasing *)error;

-(void)saveTitle:(NSString *)title andCoverArt:(NSString *)coverArt changesToAlbum:(Album *)album error:(NSError *__autoreleasing *)error;

@end
