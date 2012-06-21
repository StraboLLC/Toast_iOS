//
//  STRGalleryTabController.h
//  Toast
//
//  Created by Thomas Beatty on 6/20/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRMapGalleryViewController.h"
#import "STRTileGalleryViewController.h"

#import "CoreDataObjects.h"
#import "STRCaptureObjectManager.h"

@interface STRGalleryTabController : UIViewController {
    Album * album;
    STRCaptureObjectManager * captureManager;
    
    // View to hold the map and tile views.
    IBOutlet UIView * containerView;
    
    // Child views
    STRMapGalleryViewController * mapViewController;
    STRTileGalleryViewController * tileViewController;
}

@property(nonatomic, strong)Album * album;
@property(nonatomic, strong)STRCaptureObjectManager * captureManager;

@property(nonatomic, strong)STRMapGalleryViewController * mapGalleryViewController;
@property(nonatomic, strong)STRTileGalleryViewController * tileGalleryViewController;

-(IBAction)backButtonWasPressed:(id)sender;

-(IBAction)mapTabButtonWasPressed:(id)sender;
-(IBAction)tileTabButtonWasPressed:(id)sender;

@end
