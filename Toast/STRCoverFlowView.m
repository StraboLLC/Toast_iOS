//
//  STRCoverFlowView.m
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRCoverFlowView.h"

@interface STRCoverFlowView ()

@property(nonatomic, readwrite)NSArray * albums;

@end

@interface STRCoverFlowView (InternalMethods)

-(double)widthFromHeight:(int)height;
-(UIView *)setUpViewOfHeight:(int)height withAlbums:(NSArray *)albumArray;
-(NSString *)printFrameStats:(CGRect)frame;

@end

@interface STRCoverFlowView (UIScrollViewDelegate) <UIScrollViewDelegate>

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end

@implementation STRCoverFlowView

@synthesize albums;

- (id)initWithFrame:(CGRect)frame albums:(NSArray *)albumArray {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSLog(@"STRCoverFlowView: Initializing with frame %@", [self printFrameStats:frame]);
        
        self.albums = albumArray;
        
        // Set the padding for the albums
        padding = [self widthFromHeight:frame.size.height]/8;
        
        // Determine the apropriate size of the view
        double scrollWidth = ([self widthFromHeight:frame.size.height]+(padding*2));
        CGRect scrollFrame = CGRectMake((frame.size.width/2.0)-(scrollWidth/2.0), 0, scrollWidth, frame.size.height);
        // Create the scrollview
        scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
        NSLog(@"STRCoverFlowView: Scroll view created with frame: %@", [self printFrameStats:scrollView.frame]);
        
        // Add a larger view to the scrollview
        scrollSubView = [self setUpViewOfHeight:frame.size.height withAlbums:albumArray];
        
        // Set up the scroll view
        scrollView.contentSize = CGSizeMake(scrollSubView.frame.size.width, scrollSubView.frame.size.height);
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.clipsToBounds = NO;
        scrollView.delegate = self;
        // Prevent from zooming
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 1.0;
        
        [scrollView addSubview:scrollSubView];
        
        [self addSubview:scrollView];
        
        // Create the clip view
        clipView = [[STRClipView alloc] initWithFrame:frame];
        clipView.scrollView = scrollView;
        [self addSubview:clipView];
    }
    return self;
}

-(NSUInteger)arrayIndexForSelectedAlbum {
    int index = scrollSubView.frame.origin.x/(scrollSubView.frame.size.width/albums.count);
    NSLog(@"STRCoverFlowView: Album at index: %i selected.", index);
    return index;
}

@end

@implementation STRCoverFlowView (InternalMethods)

-(double)widthFromHeight:(int)height {
    double width = ((double)462 / (double)650) * (double)height;
    NSLog(@"STRCoverFlowView: Calculated width: %f from height: %d", width, height);
    return width;
}

-(UIView *)setUpViewOfHeight:(int)height withAlbums:(NSArray *)albumArray {
    // Determine the size of the frame
    double albumWidth = [self widthFromHeight:height];
    double width = ((albumWidth+(padding*2))*albumArray.count);
    
    NSLog(@"STRCoverFlowView: Calculated total width of scroll view: %f", width);
    
    CGRect scrollSubViewFrame = CGRectMake(0, 0, width, height);
    UIView * newSubView = [[UIView alloc] initWithFrame:scrollSubViewFrame];
    
    // Add the albums to the view
    double xMarker = padding;
    for (NSString * album in albumArray) {
        CGRect albumCoverImageViewFrame = CGRectMake(xMarker, 0, albumWidth, height);
        UIImageView * albumCoverImageView = [[UIImageView alloc] initWithFrame:albumCoverImageViewFrame];
        NSString * imageURLString = [[STRAlbumManager defaultManager] coverPathForAlbumName:album];
        NSLog(@"STRCoverFlow: Adding cover image from URL: %@", imageURLString);
        albumCoverImageView.image = [UIImage imageWithContentsOfFile:imageURLString];
        albumCoverImageView.contentMode = UIViewContentModeScaleToFill;
        [newSubView addSubview:albumCoverImageView];
        xMarker += (albumWidth+(padding*2));
    }
    
    return newSubView;
}

-(NSString *)printFrameStats:(CGRect)frame {
    return [NSString stringWithFormat:@"height: %f, width: %f, x: %f, y: %f", frame.size.height, frame.size.width, frame.origin.x, frame.origin.y];
}

@end

@implementation STRCoverFlowView (UIScrollViewDelegate)

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"STRCoverFlowView: Scroll view ended scrolling animation.");
    [self arrayIndexForSelectedAlbum];
}

@end