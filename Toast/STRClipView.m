//
//  STRClipView.m
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRClipView.h"

@implementation STRClipView

@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Pass swipe events to the scrollview
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return scrollView;
    }
    return nil;
}

// Pass touch events to the parent view 
// Allows touch on objects owned by the album detail views
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	[[self superview] touchesEnded:touches withEvent:event];
}

@end
