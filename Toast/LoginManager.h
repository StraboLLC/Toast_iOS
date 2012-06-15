//
//  LoginManager.h
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//
#import "Constants.h"
#import "CoreDataObjects.h"

#import <Foundation/Foundation.h>
#import "CurrentUser.h"

#import "NSString+uploadHash.h"
#import "NSString+downloadHash.h"

/**
 The LoginManagerDelegate protocol defines optional methods for receiving status updates about a login to the Strabo and Facebook systems.
 */
@protocol LoginManagerDelegate

@optional

/**
 Called in the case of a successful login.
 
 Called when the user is completely logged in to the Strabo system and the login is confirmed.
 */
-(void)userWasLoggedInSuccessfully;

/**
 Called in the case of a failed login.
 
 The error contains an error number as well as a text error that can be presented to the user. Error is nil if the error is unknown.
 */
-(void)loginDidFailWithError:(NSError *)error;

/**
 Called when the user has been successfully logged out.
 */
-(void)userWasLoggedOutSuccessfully;

/**
 Called if a user account is created successfully.
 
 Only called if the request is sent and the user creation is verified by the server.
 */
-(void)userAccountCreatedSuccessfully;

/**
 Called if a user account was not created successfully.
 
 
 */
-(void)userAccountCreationDidFailWithError:(NSError *)error;

@end

/**
 The LoginManager is used to log a user into the Strabo system. It should be owned by the Application Delegate and accessed through the appDelegate object although the loginManagerDelegate can be set to any controller that is handling logins and log outs.
 
 ##Logging the User In
 
 To log the user in, logUserInWithEmail:password: should be called. The object that calls this method should also implement the delegate methods userWasLoggedInSuccessfully and loginDidFailWithError to determine the status of a login.
 
 ##Logging the User Out
 
 To log the user out, you should call the logCurrentUserOut method. Implementing userWasLoggedOutSuccessfully will allow you to know when the user was successfully logged out.
 
 ##Creating New User Accounts
 
 To create a new user account, call the createNewUserWithName:email:password: method.
 
 ##Checking to see if a user is logged in.
 
 You can check to see if a user is logged in with the following techniques:
    
    * Check to see if currentUser == nil. If true, the user is logged out. If currentUser exists, the user is logged in.
    * Call the isUserLoggedIn method to determine if the user logged in.
 */
@interface LoginManager : NSObject {
    id delegate;
    CurrentUser * currentUser;
}

/**
 The LoginManagerDelegate to determine the status of the user login after login or logout are called.
 */
@property(strong) id delegate;

/**
 The object to hold information about the current user.
 */
@property(nonatomic, strong) CurrentUser * currentUser;

/**
 Determines whether the user is logged in.
 
 An alternative to checking to see if currentUser is nil.
 */
-(BOOL)isUserLoggedIn;

///---------------------------------------------------------------------------------------
/// @name Login Actions
///---------------------------------------------------------------------------------------

/**
 Logs the user into the Strabo system with an email and password.
 
 Builds a post request on the login data and then sends it to the server. Calls either userWasLoggedInSuccessfully or loginDidFailWithError: based on the server's response to the login request.
 */
-(void)logUserInWithEmail:(NSString *)emailAddress password:(NSString *)password;

/**
 Creates a new user in the Strabo system.
 
 Builds a post request with the create user data and sends it to the server. The server attempts to create a new user and responds. Upon receiving a server response, one of two delegate methods, userAccountCreatedSuccessfully or userAccountCreationDidFailWithError:, is called.
 */
-(void)registerNewUserWithName:(NSString *)name email:(NSString *)emailAddress password:(NSString *)password;

/**
 Logs the current user out.
 
 Deletes the currentUser object (currentUser will return nil) and notifies the delegate via userWasLoggedOutSuccessfully.
 */
-(void)logCurrentUserOut;

@end
