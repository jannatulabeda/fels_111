//
//  MakeURL.m
//  AFNetworking
//
//  Created by Jannatul on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import "MakeURL.h"
#import "Constants.h"

@implementation MakeURL

// Returns URL string for log in request
+(NSString *) getLogInURL {
    return [NSString stringWithFormat:@"%@%@", BASE_URL, LOG_IN_REQUEST];
}

// Returns URL string for sign up request
+ (NSString *) getSignUpURL {
    return [NSString stringWithFormat:@"%@%@", BASE_URL, SIGN_UP_REQUEST];
}

// Returns URL string for get categories request
+ (NSString *)getCategoriesURL {
    return [NSString stringWithFormat:@"%@%@", BASE_URL, GET_CATEGORIES_REQUEST];
}

// Returns URL string for create lesson request
+ (NSString *)getCreateLessonURLWithCategoryId:(int)categoryId {
    return [NSString stringWithFormat:@"%@/%@/%d%@", BASE_URL, KEY_CATEGORIES, categoryId, LESSONS_REQUEST];
}

// Returns URL string for show user request
+ (NSString *)getShowUserProfileURLWithUserId:(int)userID {
  return [NSString stringWithFormat:@"%@/%@/%d%@", BASE_URL, KEY_USERS, userID, REQUEST_EXTENSION];
}

// Returns URL string for create lesson request
+ (NSString *)getUpdateLessonURLWithLessonId:(int)lessonId {
    return [NSString stringWithFormat:@"%@/%@/%d%@", BASE_URL, KEY_LESSONS, lessonId, REQUEST_EXTENSION];
}

// Returns URL string for word list request
+ (NSString *)getWordListURL {
    return [NSString stringWithFormat:@"%@/%@%@", BASE_URL, KEY_WORDS, REQUEST_EXTENSION];
}

//Returns URL string for update profile request
+ (NSString *)getUpdateProfileURLWithUserId:(int)userID {
  return [NSString stringWithFormat:@"%@/%@/%d%@", BASE_URL, KEY_USERS, userID, REQUEST_EXTENSION];
}

@end
