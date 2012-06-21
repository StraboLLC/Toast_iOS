//
//  STRCaptureObjectManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/20/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRCaptureObjectManager.h"

@implementation STRCaptureObjectManager

@synthesize album;

+(STRCaptureObjectManager *)captureManagerWithAlbum:(Album *)referencedAlbum {
    STRCaptureObjectManager * newCaptureManager = [[STRCaptureObjectManager alloc] init];
    newCaptureManager.album = referencedAlbum;
    return newCaptureManager;
}

#pragma mark - Getting Captures

-(NSArray *)allCaptures {
    return [NSArray arrayWithArray:[self.album.captures allObjects]];
}

-(NSArray *)allVideoCaptures {
    NSMutableArray * captures = [NSMutableArray arrayWithArray:[self allCaptures]];
    for (Capture * capture in captures) {
        if (![capture.type isEqualToString:@"video"]) {
            [captures removeObject:capture];
        }
    }
    return captures;
}

#pragma mark - Utility Methods

-(void)logAllAssociatedCaptures {
    if (![[self allCaptures] count]) {
        NSLog(@"STRCaptureObjectManager: There are no captures in this album.");
    }
    for (Capture * capture in [self allCaptures]) {
        NSLog(@"STRCaptureObjectManager: Found capture in this album %@: %@ - %@.", self.album.title, capture.title, capture.token);
    }
}

@end