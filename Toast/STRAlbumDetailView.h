//
//  STRAlbumDetailView.h
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataObjects.h"

/**
 Alerts the super when the user takes action associated with  STRAlbumDetailView
 */
@protocol STRAlbumDetailViewDelegate

@required

/**
 This method is called when a button on one of the albums is tapped.
 
 Signifies that the owner of the view should take the apropriate action to display a gallery associated with the album that was tapped by the user.
 
 @param album The [STRAlbumDetailView] that called the method.
 */
-(void)albumWasTapped:(Album *)album;

@end

/**
 A view containing elements relevant to display pertinent information about an album.
 
 Many of these views are created by [STRCoverFlowView] when the method [STRCoverFlowView loadAlbums] is called.
 */
@interface STRAlbumDetailView : UIView {
    
    id delegate;
    
    IBOutlet UIImageView * imageView;
    IBOutlet UILabel * titleLabel;

    Album * album;
}

/**
 
 */
@property(nonatomic, strong)id delegate;

/**
 The album displayed by this view.
 
 This object is the "sender" when [STRAlbumDetailv
 */
@property(nonatomic, strong)Album * album;

/**
 An image to display the album cover art.
 */
@property(nonatomic, strong)IBOutlet UIImageView * imageView;

/**
 A label to display the title of the album.
 */
@property(nonatomic, strong)IBOutlet UILabel * titleLabel;

-(IBAction)buttonWasPressed:(id)sender;

@end
