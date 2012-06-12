//
//  Header.h
//  Toast
//
//  Created by Thomas Beatty on 6/11/12.
//  Copyright (c) 2012 Strabo. All rights reserved.
//

#ifndef Toast_Header_h
#define Toast_Header_h

// Connection verification salts
#define kSTRUploadSalt @"fuckch0p"
#define kSTRDownloadSalt @"g04ts"

// Server connections
#define KSTRBaseURL @"http://toastit.heroku.com/"
#define kSTRLoginURL KSTRBaseURL @"/mobile/api/login"
#define kSTRRegisterURL KSTRBaseURL @"/mobile/api/register"

// NSUserDefaults constants
#define STRNSUserDefaultsTokenKey @"STRNSUserDefaultsTokenKey"
#define STRNSUserDefaultsEmailKey @"STRNSUserDefaultsEmailKey"
#define STRNSUserDefaultsUserIDKey @"STRNSUserDefaultsUserIDKey"

#endif
