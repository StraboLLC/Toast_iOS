//
//  Capture.h
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Capture : NSManagedObject

@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * mediaURL;
@property (nonatomic, retain) NSString * geodataURL;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * uploadDate;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) Album *album;

@end
