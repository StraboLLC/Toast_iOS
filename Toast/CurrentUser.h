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
    NSString * email;
    NSString * token;
    NSNumber * userID;
}

///---------------------------------------------------------------------------------------
/// @name User Login Data
///---------------------------------------------------------------------------------------

/**
 The user's email address.
 
 A unique string used to identify the user.
 */
@property(nonatomic, strong, readonly)NSString * email;

/** 
 Strabo-specific login token. 
 */
@property(nonatomic, strong, readonly)NSString * token;

/**
 Strabo-specific user-ID.
 */
@property(nonatomic, strong, readonly)NSNumber * userID;

/**
 Creates and returns a new instance of a CurrentUser object.
 
 This method should be used to construct a CurrentUser object whenever the user logs in or the login data is retrieved from NSUserDefaults.
 
 @param theEmail Email address.
 
 @param theUserID The UserID which should have been obtained from the server.
 
 @param theToken A unique token generated from the user's email and a salt. This should be the upload token, not the download token.
 
 @return A new instance of CurrentUser
 */
+(CurrentUser *)currentUserWithEmail:(NSString *)theEmail userID:(NSNumber *)theUserID token:(NSString *)theToken;

@end
