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

/**
 A cover flow view to select albums in Toast.
 
 It should be noted that the album image size is expected to be 462 x 650. This aspect ratio is used to determine the paging distance and other size-related properties. Album cover images that do not fit this ratio will be streteched and the results might be unexpected.
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

@property(nonatomic, readonly)NSArray * albums;

/**
 A custom init method.
 
 Allows an array of albums to be passed to the STRCoverFlowView so that they may be displayed in the scroll view.
 
 @param frame The frame in which this view will be placed.
 
 @param albumArray An array of album names to be included in the cover flow.
 */
- (id)initWithFrame:(CGRect)frame albums:(NSArray *)albumArray;

/**
 Gets the index of the album object in albums that is currently selected.
 
 @return Integer value of the index of the currently selected album in albums.
 */
-(NSUInteger)arrayIndexForSelectedAlbum;

@end
