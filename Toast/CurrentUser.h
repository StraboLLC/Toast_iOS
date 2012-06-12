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
    NSString * name;
    NSString * email;
    NSString * token;
    NSNumber * userID;
}

///---------------------------------------------------------------------------------------
/// @name User Login Data
///---------------------------------------------------------------------------------------

/**
 User-defined name.
 
 This should be the user's name or username. It is non-strabo-specific and could be many words.
 */
@property(nonatomic, strong)NSString * name;

/**
 The user's email address.
 
 A unique string used to identify the user.
 */
@property(nonatomic, strong)NSString * email;

/** 
 Strabo-specific login token. 
 */
@property(nonatomic, strong)NSString * token;

/**
 Strabo-specific user-ID.
 */
@property(nonatomic, strong)NSNumber * userID;

@end
