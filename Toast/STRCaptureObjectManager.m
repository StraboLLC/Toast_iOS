//
//  STRCaptureObjectManager.m
//  Toast
//
//  Created by Thomas Beatty on 6/20/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRCaptureObjectManager.h"
#import "STRAppDelegate.h"

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

#pragma mark - New Captures
-(Capture *)newCaptureWithToken:(NSString *)token type:(NSString *)type latitude:(double)latitude longitude:(double)longitude {
    
    NSManagedObjectContext * context = [(STRAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Path constants
    NSString * capturesDirectory = @"StraboCaptures";
    NSString * mediaExtension;
    if ([type isEqualToString:@"video"]) {
        mediaExtension = @".mov";
    } else if ([type isEqualToString:@"image"]) {
        mediaExtension = @".jpg";
    } else {
        mediaExtension = @".unknown";
        NSLog(@"STRCaptureObjectManager: Unknown file type detected. Unsure what file extension to append to path.");
    }
    
    Capture * newCapture = [NSEntityDescription insertNewObjectForEntityForName:@"Capture" inManagedObjectContext:context];
    newCapture.creationDate = [NSDate date];
    newCapture.geodataPath = [NSString stringWithFormat:@"%@/%@/%@.json", token, capturesDirectory, token];
    newCapture.latitude = @(latitude);
    newCapture.longitude = @(longitude);
    newCapture.mediaPath = [NSString stringWithFormat:@"%@/%@/%@%@", token, capturesDirectory, token, mediaExtension];
    newCapture.thumbnailPath = [NSString stringWithFormat:@"%@/%@/%@.png", token, capturesDirectory, token];
    newCapture.title = @"Untitled Capture";
    newCapture.token = token;
    newCapture.type = type;
    newCapture.uploadDate = [NSDate dateWithTimeIntervalSince1970:0];
    
    // Save the newly created capture to core data
    [[self album] addCapturesObject:newCapture];
    NSError * error;
    [context save:&error];
    if (error) {
        NSLog(@"STRCaptureObjectManager: !!!Error saving new capture to the managed object context: %@", error.localizedDescription);
        return nil;
    } else {
        NSLog(@"STRAlbumManager: New capture savedsuccessfully to the managed object context.");
        return newCapture;
    }
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