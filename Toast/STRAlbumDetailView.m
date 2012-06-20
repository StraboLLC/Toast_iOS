//
//  STRAlbumDetailView.m
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRAlbumDetailView.h"

@implementation STRAlbumDetailView

@synthesize imageView, titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"STRAlbumDetailView: View initialized.");
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
