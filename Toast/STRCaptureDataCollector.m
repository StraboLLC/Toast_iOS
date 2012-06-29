//
//  STRCaptureDataCollector.m
//  Toast
//
//  Created by Thomas Beatty on 6/28/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRCaptureDataCollector.h"


@interface STRCaptureDataCollector (InternalMethods)

// Capture Devices
-(AVCaptureDevice *)cameraWithPosition: (AVCaptureDevicePosition)position;
-(AVCaptureDevice *)frontFacingCamera;
-(AVCaptureDevice *)backFacingCamera;
-(AVCaptureDevice *)audioDevice;
  
@end

@implementation STRCaptureDataCollector

@synthesize delegate = _delegate;

@end

@implementation STRCaptureDataCollector (InternalMethods)

-(AVCaptureDevice *)cameraWithPosition: (AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

-(AVCaptureDevice *)frontFacingCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

-(AVCaptureDevice *)backFacingCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

-(AVCaptureDevice *)audioDevice {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if ([devices count] > 0) {
        return [devices objectAtIndex:0];
    }
    return nil;
}

@end
