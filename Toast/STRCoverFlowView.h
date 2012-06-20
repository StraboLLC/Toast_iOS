//
//  STRCoverFlowView.h
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRAlbumManager.h"

#import "STRClipView.h"
#import "STRAlbumDetailView.h"

/**
 A cover flow view to select albums in Toast.
 
 It should be noted that the album image size is expected to be 462 x 650. This aspect ratio is used to determine the paging distance and other size-related properties. Album cover images that do not fit this ratio will be streteched and the results might be unexpected.
 
 To populate the album covers, loadAlbumCovers: or loadAlbums: should be called immediately after initialization.
 */
@interface STRCoverFlowView : UIView {
    
    NSArray * albums;
    
    // Subviews
    STRClipView * clipView;
    UIScrollView * scrollView;
    UIView * scrollSubView;
    
    // Padding on the right and left of each album
    int padding;
}
/**
 The array of albums loaded into the view.
 
 The array is an array of strings if loadAlbumCovers: is used to populate the albums. If loadAlbums: is used to populate the album covers, then the array contains a series of [Album] objects.
 */
@property(nonatomic, readonly)NSArray * albums;

/**
 A custom init method.
 
 Allows an array of albums to be passed to the STRCoverFlowView so that they may be displayed in the scroll view.
 
 @param frame The frame in which this view will be placed.
 */
-(id)initWithFrame:(CGRect)frame;

/**
 Gets the index of the album object in albums that is currently selected.
 
 @return Integer value of the index of the currently selected album in albums.
 */
-(NSUInteger)arrayIndexForSelectedAlbum;

///---------------------------------------------------------------------------------------
/// @name Loading Albums
///---------------------------------------------------------------------------------------

/**
 Loads all of the possible album covers into the scroll view.
 
 @param albumCoverNames An array of NSStrings specifying the names of albums.
 */
-(void)loadAlbumCovers:(NSArray *)albumCoverNames;

/**
 Loads a specific array of albums including their covers, titles, and a button link to their gallery views.
 */
-(void)loadAlbums:(NSArray *)allAlbums;

@end
