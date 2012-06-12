//
//  LoginManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "LoginManager.h"

@interface LoginManager (InternalMethods)

@end

@implementation LoginManager

@synthesize delegate;
@synthesize currentUser;

-(void)logUserInWithEmail:(NSString *)emailAddress password:(NSString *)password {
    
}

-(void)createNewUserWithName:(NSString *)name email:(NSString *)emailAddress password:(NSString *)password {
    
}

-(void)logCurrentUserOut {
    
}

-(BOOL)isUserLoggedIn {
    
    BOOL userIsLoggedIn = (self.currentUser) ? YES : NO;

    return userIsLoggedIn;
}

@end

@implementation LoginManager (InternalMethods)

@end
