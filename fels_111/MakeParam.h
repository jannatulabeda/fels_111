//
//  MakeParam.h
//  AFNetworking
//
//  Created by Jannatul Abeda on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MakeParam : NSObject

// Generate sign in param for Sign in API
// Return parameter as a dictionary
+ (NSDictionary *)makeLoginParamWithEmail:(NSString *)email
                           password:(NSString *)password
                         rememberMe:(BOOL)rememberMe;


// Generate sign up param for Sign up API
// Return parameter as a dictionary
+ (NSDictionary *)makeSingUpParamWithName:(NSString *)name
                                   Email:(NSString *)email
                                 password:(NSString *)password
                       confirmedPassword:(NSString *)confirmedPassword;

// Generate category param for Get Categories API
// Return parameter as a dictionary
+(NSDictionary *)makeCategoryParamWithPage:(int)page
                                   perPage:(int)perPage
                                 authToken:(NSString *)authToken;

// Generate create lesson param for Create Lesson API
// Return parameter as a dictionary
+ (NSDictionary *)makeCreateLessonParamWithAuthToken:(NSString *)authToken;

// Makes show user param for Show User API
// return param as a dictionary
+ (NSDictionary *)makeShowUserParamWithAuthToken:(NSString *)authToken;
// Generate update lesson param for Update Lesson API
// Return parameter as a dictionary
+ (NSDictionary *)makeUpdateLessonParamWithLearned:(BOOL)learned
                                  resultAttributes:(NSDictionary *)resultAttribute
                                         authToken:(NSString *)authToken;
@end
