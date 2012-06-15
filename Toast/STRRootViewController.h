//
//  STRRootViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/13/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRAppDelegate.h"
#import "STRAlbumsViewController.h"
#import "STRSignInViewController.h"

/**
 A container view controller for displaying the views at startup.
 
 Handles any initial startup animations and displays a navigation controller with an [STRAlbumViewController] as its root. This View Controller will check the status of the user's login by accessing the [LoginManager] owned by the app delegate and determine whether or not to display a login/register view controller flow modally.
 */
@interface STRRootViewController : UIViewController

/**
 Dismisses any login views that have been presented modally.
 
 Should be called by a [STRRegistrationViewController] or a [STRSignInViewController] upon successful login.
 */
-(void)dismissLoginViewController;

@end
