//
//  STRAppDelegate.h
//  Toast
//
//  Created by Thomas Beatty on 6/8/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRLoginManager.h"
#import "STRAlbumObjectManager.h"
#import "STRCaptureObjectManager.h"

@interface STRAppDelegate : UIResponder <UIApplicationDelegate> {
    STRLoginManager * loginManager;
    STRAlbumObjectManager * albumManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic, readonly) STRLoginManager * loginManager;
@property (strong, nonatomic, readonly) STRAlbumObjectManager * albumManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
