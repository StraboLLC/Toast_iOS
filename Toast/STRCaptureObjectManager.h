//
//  STRCaptureObjectManager.h
//  Toast
//
//  Created by Thomas Beatty on 6/20/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataObjects.h"

/**
 Handles the creation, deletion, editing, and retrieval of captures.
 
 This object should be handled differently than the [STRAlbumObjectManager]. Instead of being owned by the [STRAppDelegate], a new STRCaptureObjectManager is instantiated every time you need to handle captures within an album.
 
 It might be convenient to instantiate a new STRCaptureObjectManager and store it as an instance variable on an object that needs to manipulate the captures wihin an album with some frequency. For example, it would be good to 
 */
@interface STRCaptureObjectManager : NSObject {
    Album * album;
}

@property(nonatomic, strong)Album * album;

+(STRCaptureObjectManager *)captureManagerWithAlbum:(Album *)referencedAlbum;

///---------------------------------------------------------------------------------------
/// @name Getting Captures
///---------------------------------------------------------------------------------------

/**
 Returns an array of all of the capture objects for the album.
 
 @return An array of [Capture] objects.
 */
-(NSArray *)allCaptures;

/**
 Returns all of the video captures associated with the album.
 
 @return an array of [Capture] objects.
 */
-(NSArray *)allVideoCaptures;

///---------------------------------------------------------------------------------------
/// @name Utility Methods
///---------------------------------------------------------------------------------------

/**
 Writes a list of the captures associated with the album to the log.
 */
-(void)logAllAssociatedCaptures;

@end
