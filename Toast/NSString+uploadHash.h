//
//  NSString+uploadHash.h
//  Toast
//
//  Created by Thomas Beatty on 6/12/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#import "Constants.h"

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"

/**
 Extends NSString with a function to produce a string and a salt hashed with the MD5 algorithm.
 */
@interface NSString (uploadHash)

/**
 Appends the kSTRUploadSalt (from [Constants.h]) to the end of the string and hashes it with the MD5 algorithm.
 
 Used for generating tokens to upload to the server.
 */
-(NSString *)uploadHash;

@end
