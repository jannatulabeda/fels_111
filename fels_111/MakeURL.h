//
//  MakeURL.h
//  AFNetworking
//
//  Created by Jannatul on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MakeURL : NSObject

// Returns URL string for sign in request
+ (NSString *) getLogInURL;

// Returns URL string for sign up request
+ (NSString *) getSignUpURL;

// Returns URL string for get categories request
+ (NSString *)getCategoriesURL;

// Returns URL string for create lesson request
+ (NSString *)getCreateLessonURLWithCategoryId:(int)categoryId;

// Returns URL string for show user request
+ (NSString *)getShowUserProfileURLWithUserId:(int)userID;

@end
