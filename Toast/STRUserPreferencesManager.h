//
//  STRUserPreferencesManager.h
//  Toast
//
//  Created by Thomas Beatty on 6/21/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "STRAppDelegate.h"

/**
 Used to set and get preferences for a specific user.
 
 Holds all of the preferences that relate to a user.
 */
@interface STRUserPreferencesManager : NSObject

///---------------------------------------------------------------------------------------
/// @name Utility Methods
///---------------------------------------------------------------------------------------

/**
 Sets up a new preferences manager with the current user's preferences.
 
 @return A new STRUserPreferences with the current user pre loaded.
 */
+(STRUserPreferencesManager *)preferencesForCurrentUser;

/**
 Used to get a CLLocationAccuracy constant for setting the location accuracy of a CLLocationManager.
 
 [STRCaptureViewController] and others should implement this method to determine the desired accuracy to set the location data collection properly.
 
 @return CLLocationAccuracy The desired accuracy for location updates as dictated by a CLLocationManager.
 */
-(CLLocationAccuracy)desiredLocationAccuracy;

@end
