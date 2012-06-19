//
//  STRNewAlbumViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRAppDelegate.h"
#import "STRCoverFlowView.h"


@interface STRNewAlbumViewController : UIViewController {
    IBOutlet UITextField * titleField;
    IBOutlet UIView * coverFlowView;
    STRCoverFlowView * coverFlowSubView;
}

///---------------------------------------------------------------------------------------
/// @name Button Handling
///---------------------------------------------------------------------------------------

-(IBAction)submitButtonWasPressed:(id)sender;

@end
