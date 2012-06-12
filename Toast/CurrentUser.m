//
//  CurrentUser.m
//  Ramble
//
//  Created by Thomas Beatty on 1/19/12.
//  Copyright (c) 2012 Strabo LLC. All rights reserved.
//

#import "CurrentUser.h"

@interface CurrentUser ()
@property(nonatomic, strong, readwrite)NSString * email;
@property(nonatomic, strong, readwrite)NSString * token;
@property(nonatomic, strong, readwrite)NSNumber * userID;
@end

@implementation CurrentUser

@synthesize email, token, userID;

+(CurrentUser *)currentUserWithEmail:(NSString *)theEmail userID:(NSNumber *)theUserID token:(NSString *)theToken {
    CurrentUser * currentUser = [[CurrentUser alloc] init];
    
    currentUser.email = theEmail;
    currentUser.userID = theUserID;
    currentUser.token = theToken;
    
    return currentUser;
}

@end
