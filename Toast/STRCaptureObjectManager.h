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

-(NSArray *)allCaptures;
-(NSArray *)allVideoCaptures;

///---------------------------------------------------------------------------------------
/// @name Utility Methods
///---------------------------------------------------------------------------------------

-(void)logAllAssociatedCaptures;

@end
