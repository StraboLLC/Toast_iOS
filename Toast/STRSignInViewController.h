//
//  STRSignInViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/11/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRRootViewController.h"

/**
 Orchestrates a user's login process.
 
 This view should be presented when a previously registered user needs to sign in to the Strabo system. The STRSignInViewController implements a [LoginManager] to log the user in based on the information in the view's email and password text fields. It should also implements a [LoginManagerDelegate] to handle any errors and alert the user of an invalid or unsuccessful login.
 */
@interface STRSignInViewController : UIViewController {
    
    IBOutlet UITextField * emailField;
    IBOutlet UITextField * passwordField;

}

///---------------------------------------------------------------------------------------
/// @name Button Handling
///---------------------------------------------------------------------------------------

/**
 Handles the action when the submit button is pressed.
 
 Should call the [LoginManager logUserInWithEmail:password:] on the [LoginManager] to log the user in.
 */
-(IBAction)submitButtonWasPressed:(id)sender;

/**
 Handles the action when the back button is pressed.
 
 Pops the current view controller from the navigation view controller stack.
 */
-(IBAction)backButtonWasPressed:(id)sender;

@end
