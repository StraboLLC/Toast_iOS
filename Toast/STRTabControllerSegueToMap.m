//
//  STRTabControllerSegue.m
//  Toast
//
//  Created by Thomas Beatty on 6/21/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRTabControllerSegueToMap.h"

@implementation STRTabControllerSegueToMap

// Called to perform the segue
-(void)perform {
    UIViewController *src = [(STRGalleryTabController *)self.sourceViewController tileGalleryViewController];    
    UIViewController *dst = [(STRGalleryTabController *)self.sourceViewController mapGalleryViewController];
    NSLog(@"STRTabControllerSegue: Now performing segue transition to map");
    [src transitionFromViewController:src toViewController:dst duration:0.0 options:UIViewAnimationTransitionNone animations:^{} completion:nil];
}

@end
