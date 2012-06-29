//
//  STRCaptureDataCollector.h
//  Toast
//
//  Created by Thomas Beatty on 6/28/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface STRCaptureDataCollector : NSObject {
    id delegate;
}

@property(strong)id delegate;

@end
