//
//  Album.h
//  Toast
//
//  Created by Thomas Beatty on 6/18/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Capture, User;

/**
 An album holds many captures.
 */
@interface Album : NSManagedObject

/**
 A description of the content of the album.
 */
@property (nonatomic, retain) NSString * abstract;
@property (nonatomic, retain) NSString * coverArt;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSSet *captures;
@property (nonatomic, retain) User *user;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addCapturesObject:(Capture *)value;
- (void)removeCapturesObject:(Capture *)value;
- (void)addCaptures:(NSSet *)values;
- (void)removeCaptures:(NSSet *)values;

@end
