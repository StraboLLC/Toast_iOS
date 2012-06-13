//
//  STRAppDelegate.h
//  Toast
//
//  Created by Thomas Beatty on 6/8/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManager.h"

@interface STRAppDelegate : UIResponder <UIApplicationDelegate> {
    LoginManager * loginManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic, readonly) LoginManager * loginManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
