//
//  Capture.h
//  Toast
//
//  Created by Thomas Beatty on 6/18/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

/**
 Contains information about captured media.
 
 ##Paths
 
 File paths are stored relative to the application documents directory. There are three files associated with a capture:
 - geodataPath | A JSON file that contains geo data associated with the capture.
 - mediaPath | The captured media associated with the capture. At the time of writing, this could be either a .mov or a .jpg file (movie or image).
 - thumbnailPath | A small PNG image file which contains a thumbnail preview of the capture.
 
 To get the absolute path to any of the above files, you must append the stored path to the end of the documents directory path. For example, if we have a Capture object called "capture":
 
    NSString * absoluteMediaPath = [NSDocumentsDirectory() stringByAppendingPathComponent:capture.mediaPath];
 
 ##Types
 
 There are four different types of possible captured media: video, image, note, and audio. This object is set up so that it contains all of the information necessary for any one of these media types.
 */
@interface Capture : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * geodataPath;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * mediaPath;
@property (nonatomic, retain) NSString * thumbnailPath;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * uploadDate;
@property (nonatomic, retain) Album *album;

@end
