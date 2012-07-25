//
//  NSString+Hash.h
//  STRABO-MultiRecorder
//
//  Created by Thomas N Beatty on 7/13/12.
//  Copyright (c) 2012 Strabo, LLC. All rights reserved.
//
#import "Constants.h"

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

/**
 Extends NSString with functions to produced hashed strings.
 */
@interface NSString (Hash)

///---------------------------------------------------------------------------------------
/// @name Hash Functions
///---------------------------------------------------------------------------------------

/**
 Hashes a given string with the MD5 algorithm.
 */
-(NSString *)MD5;

/**
 Hashes a given string with the SHA2 algorithm.
 */
-(NSString *)SHA2;

///---------------------------------------------------------------------------------------
/// @name Salted Tokens
///---------------------------------------------------------------------------------------

/**
 Appends the kSTRUploadSalt (from [Constants.h]) to the end of the string and hashes it with the MD5 algorithm.
 
 Used for generating tokens to upload to the server.
 */
-(NSString *)uploadHash;

/**
 Appends the kSTRDownloadSalt (from [Constants.h]) to the end of the string and hashes it with the MD5 algorithm.
 
 Used for verifying server responses as valid.
 */
-(NSString *)downloadHash;

@end
