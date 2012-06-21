//
//  STRTabControllerSegueToTile.m
//  Toast
//
//  Created by Thomas Beatty on 6/21/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRTabControllerSegueToTile.h"

@implementation STRTabControllerSegueToTile

-(void)perform {
    UIViewController *src = [(STRGalleryTabController *)self.sourceViewController mapGalleryViewController];    
    UIViewController *dst = [(STRGalleryTabController *)self.sourceViewController tileGalleryViewController];
    NSLog(@"STRTabControllerSegue: Now performing segue transition to tile");
    [src transitionFromViewController:src toViewController:dst duration:0.0 options:UIViewAnimationTransitionNone animations:^{} completion:nil];
}

@end