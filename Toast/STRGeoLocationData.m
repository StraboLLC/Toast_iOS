//
//  STRGeoLocationData.m
//  Toast
//
//  Created by Thomas Beatty on 6/28/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "STRGeoLocationData.h"

@implementation STRGeoLocationData

-(id)init {
    if (self) {
        dataPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addDataPointWithLatitude:(double)latitude longitude:(double)longitude heading:(double)heading timestamp:(double)timestamp accuracy:(double)accuracy {
    
    NSDictionary * point = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithDouble:latitude], [NSNumber numberWithDouble:longitude], nil], heading, accuracy, timestamp, nil] forKeys:[NSArray arrayWithObjects:@"coords", @"heading", @"accuracy", @"timestamp", nil]];
    [dataPoints addObject:point];
}

-(NSArray *)dataPointList {
    return dataPoints;
}

@end
