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
extern NSString *const GET_CATEGORIES_REQUEST; // Get categories request

#pragma mark - KEY constants
extern NSString *const KEY_ID;
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
extern NSString *const KEY_CATEGORIES;
extern NSString *const KEY_PAGE;
extern NSString *const KEY_PER_PAGE;
extern NSString *const KEY_PHOTO;
extern NSString *const KEY_TOTAL_PAGES;

#pragma mark - Data validation Constants
extern NSInteger const MAX_LENGTH_USER_NAME;
extern NSInteger const MAX_LENGTH_EMAIL;
extern NSInteger const MIN_LENGTH_PASSWORD;

#pragma mark - resources 

extern NSString *const CHECKED_IMAGE;
extern NSString *const UNCHECKED_IMAGE;

#pragma mark - Error Strings
extern NSString *const ERROR_EMAIL_REQUIRED;
extern NSString *const ERROR_EMAIL_INVALID;
extern NSString *const ERROR_PASSWORD_REQUIRED;
extern NSString *const ERROR_NAME_REQUIRED;
extern NSString *const ERROR_INVALID_COMBINATION;

#pragma mark - KeyChain Keys
extern NSString *const KEYCHAIN_KEY_SERVICE;
extern NSString *const KEYCHAIN_KEY_TOKEN;
extern NSString *const KEYCHAIN_KEY_ID;

@end
