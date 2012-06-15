//
//  Album.h
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * coverArtURL;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *capture;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addCaptureObject:(NSManagedObject *)value;
- (void)removeCaptureObject:(NSManagedObject *)value;
- (void)addCapture:(NSSet *)values;
- (void)removeCapture:(NSSet *)values;

@end
