//
//  LoginManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "LoginManager.h"
#import "STRAppDelegate.h"

@interface LoginManager (InternalMethods)
-(NSData *)sendSynchronousPostRequestTo:(NSURL *)outgoingURL withKeyValuePairs:(NSDictionary *)args;
-(void)saveLoginEmail:(NSString *)email userID:(NSNumber *)userID token:(NSString *)token;
-(void)refreshLogin;
-(BOOL)validateResponseToken:(NSString *)token forUserID:(NSNumber *)userID;
-(NSDictionary *)validateResponseData:(NSData *)responseData forError:(NSError *__autoreleasing *)error;
-(BOOL)validateJSON:(NSDictionary *)responseDictionary forServerError:(NSError *__autoreleasing *)error;
-(void)newCoreDataUserObjectWithID:(NSNumber *)userID;
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
    NSLog(@"LoginManager: Attempting to log in user: %@", emailAddress);
    
    // Request login response from the server
    NSDictionary * keyValuePairs = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:emailAddress, password.MD5, emailAddress.uploadHash, nil] 
                                                               forKeys:[NSArray arrayWithObjects:@"email", @"password", @"token", nil]];
    NSData * responseData = [self sendSynchronousPostRequestTo:[NSURL URLWithString:kSTRLoginURL] 
                                             withKeyValuePairs:keyValuePairs];
    NSLog(@"LoginManager: Returned Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    // Check for errors
    NSError * error;
    NSDictionary * responseDictionary = [self validateResponseData:responseData forError:&error];
    // Notify the delegate of an error if one exists
    if (!responseDictionary || error) {
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            NSLog(@"LoginManager: Notifying delegate loginDidFailWithError: %@.", error.localizedDescription);
            [delegate loginDidFailWithError:error];
        }
        return;
    }
    
    BOOL isValidJSON = [self validateJSON:responseDictionary forServerError:&error];
    // Notify the delegate of an error if one exists
    if (!isValidJSON || error) {
        if ([self.delegate respondsToSelector:@selector(loginDidFailWithError:)]) {
            NSLog(@"LoginManager: Notifying delegate loginDidFailWithError: %@.", error.localizedDescription);
            [delegate loginDidFailWithError:error];
        }
        return;
    }
    
    // Handle the response (if there were no errors)
    // by logging the user in.
    [self saveLoginEmail:emailAddress 
                  userID:[responseDictionary objectForKey:@"user_id"] 
                   token:emailAddress.uploadHash];
}

-(void)registerNewUserWithName:(NSString *)name email:(NSString *)emailAddress password:(NSString *)password {
    NSLog(@"LoginManager: Attempting to register a user.");
    
    // Send a request to the server
    // Request login response from the server
    NSDictionary * keyValuePairs = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name, emailAddress, password.MD5, emailAddress.uploadHash, nil] 
                                                               forKeys:[NSArray arrayWithObjects:@"name", @"email", @"password", @"token", nil]];
    NSData * responseData = [self sendSynchronousPostRequestTo:[NSURL URLWithString:kSTRRegisterURL] 
                                             withKeyValuePairs:keyValuePairs];
    NSLog(@"LoginManager: Returned Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    // Check for errors
    NSError * error;
    NSDictionary * responseDictionary = [self validateResponseData:responseData forError:&error];
    // Notify the delegate of an error if one exists
    if (!responseDictionary || error) {
        if ([self.delegate respondsToSelector:@selector(userAccountCreationDidFailWithError:)]) {
            NSLog(@"LoginManager: Notifying delegate userAccountCreationDidFailWithError: %@.", error.localizedDescription);
            [delegate userAccountCreationDidFailWithError:error];
        }
        return;
    }
    
    BOOL isValidJSON = [self validateJSON:responseDictionary forServerError:&error];
    // Notify the delegate of an error if one exists
    if (!isValidJSON || error) {
        if ([self.delegate respondsToSelector:@selector(userAccountCreationDidFailWithError:)]) {
            NSLog(@"LoginManager: Notifying delegate userAccountCreationDidFailWithError: %@.", error.localizedDescription);
            [delegate userAccountCreationDidFailWithError:error];
        }
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(userAccountCreatedSuccessfully)]) {
        NSLog(@"LoginManager: Notifying delegate userAccountCreatedSuccessfully.");
        [delegate userAccountCreatedSuccessfully];
    }
    
    // Handle the response data (if there were no errors)
    // by logging the user in.
    [self saveLoginEmail:emailAddress 
                  userID:[responseDictionary objectForKey:@"user_id"] 
                   token:emailAddress.uploadHash];
}

-(void)logCurrentUserOut {
    NSLog(@"LoginManager: Logging the current user out.");
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
    
    NSLog(@"LoginManager: Will generate POST request to send to %@.", [outgoingURL absoluteURL]);
    
    // Set the params for the request
    NSMutableString * params = [NSMutableString stringWithCapacity:200];
    NSString * key;
    for (key in args) {
        NSLog(@"LoginManager: Appending value: %@ for key: %@ to the params.", [args objectForKey:key], key);
        [params appendString:[NSString stringWithFormat:@"%@=%@&", key, [args objectForKey:key]]];
    }
    
    // Generate the request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:outgoingURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Keep track of any errors
    NSError * error;
    
    // Send the request
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    // Returns nil if there was an error
    if (error) {
        NSLog(@"LoginManager: !!!Error occurred while sending the post request: %@.", error);
        
        return nil;
    }
    
    // If no error, return the received data
    return responseData;
}

#pragma mark - Login Handling

-(void)saveLoginEmail:(NSString *)email userID:(NSNumber *)userID token:(NSString *)token {
    NSLog(@"LoginManager: Saving login information to make login persistent.");
    // Create the currentUser object and add
    // the appropriate values to NSUserDefaults
    self.currentUser = [CurrentUser currentUserWithEmail:email userID:userID token:token];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.currentUser.email forKey:STRNSUserDefaultsEmailKey];
    [defaults setObject:self.currentUser.userID forKey:STRNSUserDefaultsUserIDKey];
    [defaults setObject:self.currentUser.token forKey:STRNSUserDefaultsTokenKey];
    [defaults synchronize];
    
    // Be sure to save the user to the database of logged-in users.
    [self newCoreDataUserObjectWithID:userID];
    
    NSLog(@"LoginManager: Login of user: %@ was successful.", email);
    if ([self.delegate respondsToSelector:@selector(userWasLoggedInSuccessfully)]) {
        NSLog(@"LoginManager: Notifying delegate: userWasLoggedInSuccessfully");
        [self.delegate userWasLoggedInSuccessfully];
    }
}

-(void)refreshLogin {
    NSLog(@"LoginManager: Refreshing login from NSUserDefaults.");
    // Check for logged in user in NSUserDefaults and
    // create a currentUser object if necessary
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    // Check NSUserDefaults
    if ([defaults objectForKey:STRNSUserDefaultsEmailKey]
        &&[defaults objectForKey:STRNSUserDefaultsUserIDKey]
        &&[defaults objectForKey:STRNSUserDefaultsTokenKey]) {
        NSLog(@"LoginManager: User appears to be logged in. Setting up current user object now");
        self.currentUser = [CurrentUser currentUserWithEmail:[defaults objectForKey:STRNSUserDefaultsEmailKey] 
                                                      userID:[defaults objectForKey:STRNSUserDefaultsUserIDKey] 
                                                       token:[defaults objectForKey:STRNSUserDefaultsTokenKey]];
    } else {
        NSLog(@"LoginManager: User is not currently logged in.");
        [self logCurrentUserOut];
    }
}

-(void)newCoreDataUserObjectWithID:(NSNumber *)userID {
    
    // To prevent duplicate users in the Core Data stack,
    // search for user objects with the given userID.
    // Set up the predicate
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    // Get pointers to the managed object contexts
    STRAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = [appDelegate managedObjectContext];
    // Set up the request
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError * error;
    NSArray *users = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"LoginManager: There was an error accessing the managed object context.");
        // Handle error
        
    } else if ([users count] != 0) {
        NSLog(@"LoginManager: %i duplicate user object found in the Core Data stack.", [users count]);
        
    } else {
        NSLog(@"LoginManager: No duplicate core data user objects found.");
        User * newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        newUser.userID = userID;
        NSError * error;
        [context save:&error];
        if (error) {
            // Handle error
        } else {
            NSLog(@"LoginManager: New user object saved successfully to core data stack.");
        }
    }
}

#pragma mark - Server Validation

-(BOOL)validateResponseToken:(NSString *)token forUserID:(NSNumber *)userID {
    NSLog(@"LoginManager: Validating server response token.");
    if ([token isEqualToString:userID.stringValue.downloadHash]) {
        NSLog(@"LoginManager: Server response token is valid.");
        return YES;
    } 
    NSLog(@"LoginManager: Server response token is invalid.");
    return NO;
}

-(NSDictionary *)validateResponseData:(NSData *)responseData forError:(NSError *__autoreleasing *)error {
    // Check for non-nil response data.
    if (!responseData) {
        NSLog(@"LoginManager: !!!ERROR: Response data is nil - an unknown error occurred.");
        *error = [NSError errorWithDomain:@"STR" 
                                     code:5101
                                 userInfo:[NSDictionary dictionaryWithObject:@"Unknown Error" 
                                                                      forKey:NSLocalizedDescriptionKey]];
        return nil;
    }
    
    // Check for a parse error
    NSError * parseError;
    NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
    if (parseError) {
        NSLog(@"LoginManager: !!!ERROR: There was an error parsing the JSON data from the server.");
        *error = parseError;
        return nil;
    }
    NSLog(@"LoginManager: Successfully created dictionary from server JSON response.");
    return responseDictionary;
}

-(BOOL)validateJSON:(NSDictionary *)responseDictionary forServerError:(NSError *__autoreleasing *)error {
    NSLog(@"LoginManager: Validating response dictionary.");
    // Check for an error from the server.
    if ([[responseDictionary objectForKey:@"error_present"] boolValue]) {
        NSLog(@"LoginManager: !!!ERROR: Server error detected:\n     Error number: %@\n     Error description:%@.", [responseDictionary objectForKey:@"error_number"], [responseDictionary objectForKey:@"error_string"]);
        *error = [NSError errorWithDomain:@"STR" 
                                     code:[[responseDictionary objectForKey:@"error_number"] intValue]
                                 userInfo:[NSDictionary dictionaryWithObject:[responseDictionary objectForKey:@"error_string"] 
                                                                      forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    // Crosscheck the server response token
    if (![self validateResponseToken:[responseDictionary objectForKey:@"token"] forUserID:[responseDictionary objectForKey:@"user_id"]]) {
        *error = [NSError errorWithDomain:@"STR" 
                                     code:5111
                                 userInfo:[NSDictionary dictionaryWithObject:@"Server returned invalid token" 
                                                                      forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    NSLog(@"LoginManager: Dictionary validated and server returned positive, error-free response.");
    return YES;
}

@end
