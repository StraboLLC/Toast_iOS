//
//  User.h
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSSet *album;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAlbumObject:(NSManagedObject *)value;
- (void)removeAlbumObject:(NSManagedObject *)value;
- (void)addAlbum:(NSSet *)values;
- (void)removeAlbum:(NSSet *)values;

@end
