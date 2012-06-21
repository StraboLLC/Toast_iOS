//
//  STRAlbumPreferencesViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/15/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRCoverFlowView.h"

@interface STRAlbumPreferencesViewController : UIViewController {
    
    Album * album;
    
    IBOutlet UITextField * titleField;
    IBOutlet UIView * coverFlowView;
    STRCoverFlowView * coverFlowSubView;
}

@property(nonatomic, strong)Album * album;

@property(nonatomic, strong)IBOutlet UITextField * titleField;

-(IBAction)submitButtonWasPressed:(id)sender;
-(IBAction)cancelButtonWasPressed:(id)sender;

@end
