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

-(double)widthFromHeight:(int)height withRatio:(double)ratio;
-(UIView *)setUpViewWithHeight:(int)height withAlbumNames:(NSArray *)albumArray;
-(UIView *)setUpViewWithHeight:(int)height withAlbums:(NSArray *)albumArray;
-(NSString *)printFrameStats:(CGRect)frame;

@end

@interface STRCoverFlowView (UIScrollViewDelegate) <UIScrollViewDelegate>

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end

@interface STRAlbumDetailView (STRAlbumDetailViewDelegate) <STRAlbumDetailViewDelegate>

-(void)albumWasTapped:(Album *)album;

@end

@implementation STRCoverFlowView

@synthesize delegate;
@synthesize albums;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"STRCoverFlowView: Initializing with frame: %@.", [self printFrameStats:frame]);
    }
    return self;
}

-(NSUInteger)arrayIndexForSelectedAlbum {
    int index = (int)scrollView.contentOffset.x/((int)scrollSubView.frame.size.width/(int)albums.count);
    NSLog(@"STRCoverFlowView: Content-offset: %f, total width: %i, album count: %i", scrollView.contentOffset.x, (int)scrollSubView.frame.size.width, albums.count);
    NSLog(@"STRCoverFlowView: Album at index: %i selected.", index);
    return index;
}

-(void)scrollToIndex:(NSInteger)index {
    scrollView.contentOffset = CGPointMake(((int)index*scrollView.frame.size.width), 0);
}

#pragma mark - Loading Albums

-(void)loadAlbumCovers:(NSArray *)albumCoverNames {
    // Just album covers are to be loaded: 
    // album names are not shown here - just images.
    
    // Set the albums property to be the array that was passed to this method
    self.albums = albumCoverNames;
    
    // Set the album padding
    padding = 20;
    
    // Determine the apropriate size of the view
    double scrollWidth = ([self widthFromHeight:self.frame.size.height withRatio:((double)462 / (double)650)]+(padding*2));
    CGRect scrollFrame = CGRectMake((self.frame.size.width/2.0)-(scrollWidth/2.0), 0, scrollWidth, self.frame.size.height);
    // Create the scrollview
    scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    NSLog(@"STRCoverFlowView: Scroll view created with frame: %@", [self printFrameStats:scrollView.frame]);
    
    // Add the scrolling content to the scrollView
    scrollSubView = [self setUpViewWithHeight:self.frame.size.height withAlbumNames:albumCoverNames];
    
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
    clipView = [[STRClipView alloc] initWithFrame:self.frame];
    clipView.scrollView = scrollView;
    
    [self addSubview:clipView];
}

-(void)loadAlbums:(NSArray *)allAlbums {
    // Loading STRAlbumDetailViews here so that both
    // album covers are loaded, as well as the album titles
    
    // Set the albums property to be the array
    // that was passed to this method
    self.albums = allAlbums;
    
    // Set the album padding
    padding = 20;
    
    // Determine the apropriate size of the view
    double scrollWidth = ([self widthFromHeight:self.frame.size.height withRatio:((double)230 / (double)360)]+(padding*2));
    CGRect scrollFrame = CGRectMake((self.frame.size.width/2.0)-(scrollWidth/2.0), 0, scrollWidth, self.frame.size.height);
    // Create the scrollview
    scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    NSLog(@"STRCoverFlowView: Scroll view created with frame: %@", [self printFrameStats:scrollView.frame]);
    
    scrollSubView = [self setUpViewWithHeight:self.frame.size.height withAlbums:allAlbums];
    
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
    clipView = [[STRClipView alloc] initWithFrame:self.frame];
    clipView.scrollView = scrollView;
    
    //[self addSubview:clipView];
}

@end

@implementation STRCoverFlowView (InternalMethods)

-(double)widthFromHeight:(int)height withRatio:(double)ratio {
    double width = ratio * (double)height;
    NSLog(@"STRCoverFlowView: Calculated width: %f from height: %d", width, height);
    return width;
}

-(UIView *)setUpViewWithHeight:(int)height withAlbumNames:(NSArray *)albumArray {
    // Determine the size of the frame
    double albumWidth = [self widthFromHeight:height withRatio:((double)462 / (double)650)];
    double width = ((albumWidth+(padding*2))*albumArray.count);
    
    NSLog(@"STRCoverFlowView: Calculated total width of scroll view: %f", width);
    
    CGRect scrollSubViewFrame = CGRectMake(0, 0, width, height);
    UIView * newSubView = [[UIView alloc] initWithFrame:scrollSubViewFrame];
    
    // Add the albums to the view
    double xMarker = padding;
    for (NSString * album in albumArray) {
        CGRect albumCoverImageViewFrame = CGRectMake(xMarker, 0, albumWidth, height);
        UIImageView * albumCoverImageView = [[UIImageView alloc] initWithFrame:albumCoverImageViewFrame];
        NSString * imageURLString = [[STRAlbumObjectManager defaultManager] coverPathForAlbumName:album];
        NSLog(@"STRCoverFlow: Adding cover image from URL: %@", imageURLString);
        albumCoverImageView.image = [UIImage imageWithContentsOfFile:imageURLString];
        albumCoverImageView.contentMode = UIViewContentModeScaleToFill;
        [newSubView addSubview:albumCoverImageView];
        xMarker += (albumWidth+(padding*2));
    }
    
    return newSubView;
}

-(UIView *)setUpViewWithHeight:(int)height withAlbums:(NSArray *)albumArray {
    // Determine the size of the frame
    double albumWidth = [self widthFromHeight:height withRatio:((double)230 / (double)360)];
    double width = ((albumWidth+(padding*2))*albumArray.count);
    
    NSLog(@"STRCoverFlowView: Calculated total width of scroll view: %f", width);
    
    CGRect scrollSubViewFrame = CGRectMake(0, 0, width, height);
    UIView * newSubView = [[UIView alloc] initWithFrame:scrollSubViewFrame];
    
    // Add the albums to the view
    double xMarker = padding;
    for (Album * album in albumArray) {
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"STRAlbumDetailView" owner:self options:nil];
        CGRect albumCoverDetailViewFrame = CGRectMake(xMarker, 0, albumWidth, height);
        STRAlbumDetailView * albumCoverDetailView = [xib objectAtIndex:0];
        albumCoverDetailView.frame = albumCoverDetailViewFrame;
        NSLog(@"STRCoverFlowView: Loading image at path: %@", album.coverArtURL);
        albumCoverDetailView.imageView.image = [UIImage imageWithContentsOfFile:album.coverArtURL];
        albumCoverDetailView.titleLabel.text = [album title];
        
        albumCoverDetailView.album = album;
        albumCoverDetailView.delegate = self;
        
        [newSubView addSubview:albumCoverDetailView];
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

@implementation STRCoverFlowView (STRAlbumDetailViewDelegate)

-(void)albumWasTapped:(Album *)album {
    NSLog(@"STRCoverViewController: '%@' album was tapped.", album.title);
    [self.delegate shouldPresentGalleryViewForAlbum:album];
}

@end