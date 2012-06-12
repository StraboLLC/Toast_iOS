//
//  NSString+uploadHash.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "NSString+uploadHash.h"

@implementation NSString (uploadHash)

-(NSString *)uploadHash {
    NSString * concatonatedString = [self stringByAppendingString:kSTRUploadSalt];
    
    return [concatonatedString MD5];
}

@end
