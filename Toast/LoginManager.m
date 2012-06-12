//
//  LoginManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "LoginManager.h"

@interface LoginManager (InternalMethods)
-(NSData *)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args;
-(void)saveLoginEmail:(NSString *)email userID:(NSNumber *)userID token:(NSString *)token;
-(void)refreshLogin;
-(BOOL)isValidResponseToken:(NSString *)token forUserID:(NSNumber *)userID;
@end

@implementation LoginManager

@synthesize delegate;
@synthesize currentUser;

-(id)init {
    if (self) {
    
        [self refreshLogin];
        
    }
    return self;
}

-(void)logUserInWithEmail:(NSString *)emailAddress password:(NSString *)password {
    NSLog(@"Attempting to log in user: %@", emailAddress);
    
    // Request login response from the server
    NSDictionary * keyValuePairs = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:emailAddress, password.MD5, emailAddress.uploadHash, nil] 
                                                               forKeys:[NSArray arrayWithObjects:@"email", @"password", @"token", nil]];
    NSData * responseData = [self sendSynchronousPostRequestTo:[NSURL URLWithString:kSTRLoginURL] 
                                             withKeyValuePairs:keyValuePairs];
    NSLog(@"Returned Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    // Determine if there were errors
    /************************************************************************************/
    if (!responseData) {
        NSLog(@"!!!Response data is nil - an unknown error occurred");
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            [self.delegate loginDidFailWithError:nil];
        }
        // Stop executing if there was an error
        return;
    }
    NSError * error;
    NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    if (error) {
        NSLog(@"!!!Error parsing the JSON data: %@", error);
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            [self.delegate loginDidFailWithError:error];
        }
    }
    if ([[responseDictionary objectForKey:@"error_present"] boolValue]) {
        // Log the error
        NSLog(@"!!!Server error detected:\n     Error number: %@\n     Error description:%@", [responseDictionary objectForKey:@"error_number"], [responseDictionary objectForKey:@"error_string"]);
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            // Create an error to pass to the delegate
            NSError * theError = [NSError errorWithDomain:@"STR" 
                                                     code:[[responseDictionary objectForKey:@"error_number"] intValue]
                                                 userInfo:[NSDictionary dictionaryWithObject:[responseDictionary objectForKey:@"error_string"] 
                                                                                      forKey:NSLocalizedDescriptionKey]];
            // Call the delegate method
            [self.delegate loginDidFailWithError:theError];
        }
        // Stop executing
        return;
    }
    /************************************************************************************/
    
    // Handle the response data if there were no errors
    // Log the user in
    [self saveLoginEmail:emailAddress 
                  userID:[responseDictionary objectForKey:@"user_id"] 
                   token:emailAddress.uploadHash];
}

-(void)registerNewUserWithName:(NSString *)name email:(NSString *)emailAddress password:(NSString *)password {
    NSLog(@"Attempting to register a user");
    #warning Incomplete implementation - error handling
#warning Notify user of successful registration
    
    // Send a request to the server
    // Request login response from the server
    NSDictionary * keyValuePairs = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name, emailAddress, password.MD5, emailAddress.uploadHash, nil] 
                                                               forKeys:[NSArray arrayWithObjects:@"name", @"email", @"password", @"token", nil]];
    NSData * responseData = [self sendSynchronousPostRequestTo:[NSURL URLWithString:kSTRRegisterURL] 
                                             withKeyValuePairs:keyValuePairs];
    NSLog(@"Returned Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    // Determine if there were errors
    /************************************************************************************/
    if (!responseData) {
        NSLog(@"!!!Response data is nil - an unknown error occurred");
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            [self.delegate loginDidFailWithError:nil];
        }
        // Stop executing if there was an error
        return;
    }
    NSError * error;
    NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    if (error) {
        NSLog(@"!!!Error parsing the JSON data: %@", error);
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            [self.delegate loginDidFailWithError:error];
        }
    }
    if ([[responseDictionary objectForKey:@"error_present"] boolValue]) {
        // Log the error
        NSLog(@"!!!Server error detected:\n     Error number: %@\n     Error description:%@", [responseDictionary objectForKey:@"error_number"], [responseDictionary objectForKey:@"error_string"]);
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            // Create an error to pass to the delegate
            NSError * theError = [NSError errorWithDomain:@"STR" 
                                                     code:[[responseDictionary objectForKey:@"error_number"] intValue]
                                                 userInfo:[NSDictionary dictionaryWithObject:[responseDictionary objectForKey:@"error_string"] 
                                                                                      forKey:NSLocalizedDescriptionKey]];
            // Call the delegate method
            [self.delegate loginDidFailWithError:theError];
        }
        // Stop executing
        return;
    }
    /************************************************************************************/
    
    // Handle the response data if there were no errors
    [self saveLoginEmail:emailAddress 
                  userID:[responseDictionary objectForKey:@"user_id"] 
                   token:emailAddress.uploadHash];
}

-(void)logCurrentUserOut {
    NSLog(@"Logging the current user out");
    // Set the currentUser to nil
    self.currentUser = nil;
    // Remove necessary values from NSUserDefaults
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:STRNSUserDefaultsEmailKey];
    [defaults removeObjectForKey:STRNSUserDefaultsUserIDKey];
    [defaults removeObjectForKey:STRNSUserDefaultsTokenKey];
    
    // Notify the delegate if necessary
    if ([self.delegate respondsToSelector:@selector(userWasLoggedOutSuccessfully)]) {
        [self.delegate userWasLoggedOutSuccessfully];
    }
}

-(BOOL)isUserLoggedIn {
    return (self.currentUser) ? YES : NO;
}

@end

@implementation LoginManager (InternalMethods)

-(NSData *)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args {
#warning Not multithreaded: This needs to be done eventually.
#warning Server does not timeout: This also needs to be handled.
    
    NSLog(@"Will generate POST request to send to %@", [outgoingURL absoluteURL]);
    
    // Set the params for the request
    NSMutableString * params = [NSMutableString stringWithCapacity:200];
    NSString * key;
    for (key in args) {
        NSLog(@"Appending value: %@ for key: %@ to the params", [args objectForKey:key], key);
        [params appendString:[NSString stringWithFormat:@"%@=%@&", key, [args objectForKey:key]]];
    }
    
    // Generate the request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:outgoingURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Keep track of any errors
    NSError * error;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    // Returns nil if there was an error
    if (error) {
        NSLog(@"!!!Error occurred while sending the post request: %@", error);
        
        return nil;
    }
    
    // If no error, return the received data
    return responseData;
}

-(void)saveLoginEmail:(NSString *)email userID:(NSNumber *)userID token:(NSString *)token {
    NSLog(@"Saving login information to make login persistent");
    // Create the currentUser object and add
    // the appropriate values to NSUserDefaults
    self.currentUser = [CurrentUser currentUserWithEmail:email userID:userID token:token];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.currentUser.email forKey:STRNSUserDefaultsEmailKey];
    [defaults setObject:self.currentUser.userID forKey:STRNSUserDefaultsUserIDKey];
    [defaults setObject:self.currentUser.token forKey:STRNSUserDefaultsTokenKey];
    [defaults synchronize];
}

-(void)refreshLogin {
    NSLog(@"Refreshing login from NSUserDefaults");
    // Check for logged in user in NSUserDefaults and
    // create a currentUser object if necessary
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    // Check NSUserDefaults
    if ([defaults objectForKey:STRNSUserDefaultsEmailKey]
        &&[defaults objectForKey:STRNSUserDefaultsUserIDKey]
        &&[defaults objectForKey:STRNSUserDefaultsTokenKey]) {
        NSLog(@"User appears to be logged in. Setting up current user object now");
        self.currentUser = [CurrentUser currentUserWithEmail:[defaults objectForKey:STRNSUserDefaultsEmailKey] 
                                                      userID:[defaults objectForKey:STRNSUserDefaultsUserIDKey] 
                                                       token:[defaults objectForKey:STRNSUserDefaultsTokenKey]];
    } else {
        NSLog(@"User is not currently logged in");
        [self logCurrentUserOut];
    }
}

-(BOOL)isValidResponseToken:(NSString *)token forUserID:(NSNumber *)userID {
    #warning Incomplete implementation
    NSLog(@"Validating server response.");
    if (0) {
        
    }
    return nil; // Shut the compiler up
}

@end
