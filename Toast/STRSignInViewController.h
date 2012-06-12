//
//  STRSignInViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/11/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRSignInViewController : UIViewController {
    
    IBOutlet UITextField * emailField;
    IBOutlet UITextField * passwordField;

}

/**
 Handles the action when the login button is pressed.
 
 Should call the login method on the login manager to log the user in.
 */
-(IBAction)signInButtonWasPressed:(id)sender;

@end
