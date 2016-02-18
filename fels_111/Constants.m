//
//  Constants.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/17/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - API constants
NSString *const BASE_URL = @"https://manh-nt.herokuapp.com"; // Base URL
NSString *const LOG_IN_REQUEST = @"/login.json"; // Log in request
NSString *const SIGN_UP_REQUEST = @"/users.json"; // Sign up request

#pragma mark - KEY Constants
NSString *const KEY_EMAIL = @"email";
NSString *const KEY_PASSWORD = @"password";
NSString *const KEY_PASSWORD_CONFIRMATION = @"password_confirmation";
NSString *const KEY_REMEBER_ME = @"remember_me";
NSString *const KEY_SESSION = @"session";
NSString *const KEY_NAME = @"name";
NSString *const KEY_AVATAR = @"avatar";
NSString *const KEY_AUTH_TOKEN = @"auth_token";
NSString *const KEY_LEARNED_WORDS = @"learned_words";
NSString *const KEY_USER = @"user";
NSString *const KEY_MESSAGE_RESPONSE = @"message";

@end
