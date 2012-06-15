//
//  STRRegistrationViewController.m
//  Toast
//
//  Created by Thomas Beatty on 6/14/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRRegistrationViewController.h"

@interface STRRegistrationViewController (LoginManagerDelegate) <LoginManagerDelegate>

-(void)userAccountCreatedSuccessfully;
-(void)userAccountCreationDidFailWithError:(NSError *)error;
-(void)userWasLoggedInSuccessfully;

@end

@implementation STRRegistrationViewController

@synthesize nameTextField, emailTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

-(IBAction)backButtonWasPressed:(id)sender {
    NSLog(@"STRRegistrationViewController: Back button was pressed.");
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)submitButtonWasPressed:(id)sender {
    if ([passwordTextField.text isEqualToString:confirmPasswordTextField.text]) {
         NSLog(@"STRRegistrationViewController: Attempting to register the new user and log in.");
        STRRegistrationViewController * lastViewController = (STRRegistrationViewController *)[[(UINavigationController *)[self parentViewController] viewControllers] objectAtIndex:[(UINavigationController *)[self parentViewController] viewControllers].count-2];
        [[(STRAppDelegate *)[[UIApplication sharedApplication] delegate] loginManager] registerNewUserWithName:[[lastViewController nameTextField] text]
                                                                                                         email:[[lastViewController emailTextField] text] 
                                                                                                      password:[passwordTextField text]];
    } else {
        NSLog(@"STRRegistrationViewController: Passwords do not match.");
        #warning Incomplete implementation
    }
}

@end

@implementation STRRegistrationViewController (LoginManagerDelegate)

-(void)userAccountCreatedSuccessfully {
    NSLog(@"STRRegistrationViewController: User account was created successfully.");
    
}

-(void)userAccountCreationDidFailWithError:(NSError *)error {
    #warning Incomplete implementation
    NSLog(@"STRRegistrationViewController: !!!ERROR: Registration failed. Must notify the user of the error.");
}

-(void)userWasLoggedInSuccessfully {
    NSLog(@"STRRegistrationViewController: User was logged in successfully.");
    [(STRRootViewController *)[[self navigationController] presentingViewController] dismissLoginViewController];
}

@end