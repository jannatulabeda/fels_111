//
//  Constants.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/17/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma mark - API constants
extern NSString *const BASE_URL; // Base URL
extern NSString *const LOG_IN_REQUEST; //Log in request
extern NSString *const SIGN_UP_REQUEST; //Sign up request

#pragma mark - KEY constants
extern NSString *const KEY_EMAIL;
extern NSString *const KEY_PASSWORD;
extern NSString *const KEY_PASSWORD_CONFIRMATION;
extern NSString *const KEY_REMEBER_ME;
extern NSString *const KEY_SESSION;
extern NSString *const KEY_NAME;
extern NSString *const KEY_AVATAR;
extern NSString *const KEY_AUTH_TOKEN;
extern NSString *const KEY_LEARNED_WORDS;
extern NSString *const KEY_USER;
extern NSString *const KEY_MESSAGE_RESPONSE;

#pragma mark - Data validation Constants
extern NSInteger const MAX_LENGTH_USER_NAME;
extern NSInteger const MAX_LENGTH_EMAIL;
extern NSInteger const MIN_LENGTH_PASSWORD;

@end
