//
//  STRRegistrationViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/14/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRRootViewController.h"

/**
 Orchestrates a user's registration process.
 
 This view should be presented when a previously registered user needs to register with and then sign in to the Strabo system. The STRSignInViewController implements a [LoginManager] to log the user in based on the information in the view's email and password text fields. It should also implements a [LoginManagerDelegate] to handle any errors and alert the user of an invalid or unsuccessful registration or login.
 
 In the storyboard, this is split into two view controllers - one to handle the name and email and another to handle the password and password confirmation.
 */
@interface STRRegistrationViewController : UIViewController {
    IBOutlet UITextField * nameTextField;
    IBOutlet UITextField * emailTextField;
    IBOutlet UITextField * passwordTextField;
    IBOutlet UITextField * confirmPasswordTextField;
}

@property(nonatomic, strong)IBOutlet UITextField * nameTextField;
@property(nonatomic, strong)IBOutlet UITextField * emailTextField;

///---------------------------------------------------------------------------------------
/// @name Button Handling
///---------------------------------------------------------------------------------------

/**
 Handles the action when the back button is pressed.
 
 Pops the current view controller from the navigation view controller stack.
 */
-(IBAction)backButtonWasPressed:(id)sender;

/**
 Handles the action when the submit button is pressed.
 
 Should call the [LoginManager registerNewUserWithName:email:password:] method on the [LoginManager] to log the user in.
 */
-(IBAction)submitButtonWasPressed:(id)sender;

@end
