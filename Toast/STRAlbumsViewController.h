//
//  STRAlbumsViewController.h
//  Toast
//
//  Created by Thomas Beatty on 6/13/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRAppDelegate.h"
#import "STRGalleryTabController.h"
#import "STRAlbumPreferencesViewController.h"


#import "STRCoverFlowView.h"

/**
 Handles the coverflow view of a user's albums.
 
 Presents all of the albums owned by the current user. Each of these albums can be tapped to push the [STRAlbumGalleryViewController] initialized with that album. Also has functionality to modally present a [STRNewAlbumViewController] to create a new album.
 
 Contains a preferences button which requests the modal presentaton of a main preferences view.
 */
@interface STRAlbumsViewController : UIViewController {
    IBOutlet UIView * coverFlowView;
    STRCoverFlowView * coverFlowSubView;
}

/**
 Reloads the coverflow of a user's albums.
 
 Checks the core data stack for all of the albums associated with the user, orders them according to date created, and displays them in the cover-flow style album selector.
 */
-(void)reloadAlbums;


///---------------------------------------------------------------------------------------
/// @name Button Handling
///---------------------------------------------------------------------------------------

/**
 
 */


@end