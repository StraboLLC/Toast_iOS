//
//  LoginManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "LoginManager.h"

@interface LoginManager (InternalMethods)
-(void)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args;
@end

@implementation LoginManager

@synthesize delegate;
@synthesize currentUser;

-(void)logUserInWithEmail:(NSString *)emailAddress password:(NSString *)password {
    NSLog(@"Attempting to log in user: %@", emailAddress);
    
    
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

-(NSData *)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args {
    
    NSLog(@"Sending POST request to %@", [outgoingURL absoluteURL]);
    
    // A variable to hold the data that is returned from the server.
    NSMutableData * responseData;
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:outgoingURL];
    
    NSString *params = [[NSString alloc] initWithFormat:@"foo=bar&key=value"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError * error;
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
}

@end
