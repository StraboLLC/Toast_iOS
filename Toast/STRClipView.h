//
//  STRClipView.h
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A helper view for [STRCoverFlowView].
 
 Links to the scroll view held by a parent [STRCoverFlowView] and passes touch events to that view. This allows a small scroll view and a larger area for touch events to occur.
 */
@interface STRClipView : UIView {
    UIScrollView * scrollView;
}

/**
 The scroll view associated with the [STRCoverFlowView].
 */
@property(nonatomic, strong)UIScrollView * scrollView;

@end
