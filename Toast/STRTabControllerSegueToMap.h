//
//  STRTabControllerSegue.h
//  Toast
//
//  Created by Thomas Beatty on 6/21/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRGalleryTabController.h"

/**
 A custom storyboard segue to be used with a [STRGalleryTabController].
 
 Because the STRGalleryTabController is a container view controller and displays two other views dependent upon the tab selected, it implements this custom segue to transition between displayed views.
 */
@interface STRTabControllerSegueToMap : UIStoryboardSegue

@end
