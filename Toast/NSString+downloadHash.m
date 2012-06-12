//
//  NSString+downloadHash.m
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "NSString+downloadHash.h"

@implementation NSString (downloadHash)

-(NSString *)downloadHash {
    NSString * concatonatedString = [self stringByAppendingString:kSTRDownloadSalt];
    
    return [concatonatedString MD5];
}

@end
