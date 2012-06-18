//
//  STRSignInViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/11/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRSignInViewController.h"

@interface STRSignInViewController (STRLoginManagerDelegate) <STRLoginManagerDelegate>
-(void)userWasLoggedInSuccessfully;
-(void)loginDidFailWithError:(NSError *)error;
@end

@interface STRSignInViewController (InternalMethods)
-(void)loginUser:(NSString *)email withPassword:(NSString *)password;
@end

@implementation STRSignInViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Respond to LoginManageDelegate methods
    [[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Handling

-(IBAction)submitButtonWasPressed:(id)sender {
    NSLog(@"STRSignInViewController: Sign In button was pressed.");
    // Attempt to log the user in with the information in the text fields
    [[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] logUserInWithEmail:emailField.text 
                                                                                             password:passwordField.text];
}

-(IBAction)backButtonWasPressed:(id)sender {
    NSLog(@"STRSignInViewController: Back button was pressed.");
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation STRSignInViewController (LoginManagerDelegate)

-(void)userWasLoggedInSuccessfully {
    [(STRRootViewController *)[[self navigationController] presentingViewController] dismissLoginViewController];
}

-(void)loginDidFailWithError:(NSError *)error {
#warning Incomplete implementation
    NSLog(@"STRSignInViewController: !!!ERROR: Sign-In failed. Must notify the user of the error.");
    // Notify the user that the login failed and why.
}

@end
