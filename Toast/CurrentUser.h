//
//  CurrentUser.h
//  Ramble
//
//  Created by Thomas Beatty on 1/19/12.
//  Copyright (c) 2012 Strabo LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


/** Keeps track of the information that relates to the current user.
 
 This object holds information pertaining to a Strabo user.
 */
@interface CurrentUser : NSObject {
    NSString * token;
    NSNumber * userID;
}

///---------------------------------------------------------------------------------------
/// @name User Login Data
///---------------------------------------------------------------------------------------

/** 
 Strabo-specific login token. 
 */
@property(nonatomic, strong)NSString * token;

/**
 Strabo-specific user-ID.
 */
@property(nonatomic, strong)NSNumber * userID;

@end
