//
//  STRAlbumDetailView.h
//  Toast
//
//  Created by Thomas Beatty on 6/19/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRAlbumDetailView : UIView {
    IBOutlet UIImageView * imageView;
    IBOutlet UILabel * titleLabel;
}

@property(nonatomic, strong)IBOutlet UIImageView * imageView;
@property(nonatomic, strong)IBOutlet UILabel * titleLabel;

@end
