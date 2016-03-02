//
//  MakeParam.m
//  AFNetworking
//
//  Created by Jannatul Abeda on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import "MakeParam.h"
#import "Constants.h"

@implementation MakeParam

// Generate sign in param for Sign in API
// Return parameter as a dictionary
+ (NSDictionary *)makeLoginParamWithEmail:(NSString *)email
                                password:(NSString *)password
                              rememberMe:(BOOL)rememberMe {
    NSDictionary *param = @{KEY_SESSION :@{ KEY_EMAIL: email,
                             KEY_PASSWORD : password,
                             KEY_REMEBER_ME : (rememberMe ? @"1" : @"0")}
                            };
    return param;
}

// Generate sign up param for Sign up API
// Return parameter as a dictionary
+ (NSDictionary *)makeSingUpParamWithName:(NSString *)name
                                   Email:(NSString *)email
                                password:(NSString *)password
                       confirmedPassword:(NSString *)confirmedPassword {
    NSDictionary *param = @{KEY_USER :@{ KEY_NAME: name,
                                         KEY_EMAIL: email,
                                            KEY_PASSWORD : password,
                                            KEY_PASSWORD_CONFIRMATION : confirmedPassword}
                            };
    return param;
}

// Generate category param for Get Categories API
// Return parameter as a dictionary
+(NSDictionary *)makeCategoryParamWithPage:(int)page
                                   perPage:(int)perPage
                                 authToken:(NSString *)authToken {
    NSDictionary *param = @{KEY_PAGE: [NSNumber numberWithInt:page],
                            KEY_PER_PAGE: [NSNumber numberWithInt:perPage],
                            KEY_AUTH_TOKEN : authToken};
    return param;
}

// Generate create lesson param for Create Lesson API
// Return parameter as a dictionary
+ (NSDictionary *)makeCreateLessonParamWithAuthToken:(NSString *)authToken {
    NSDictionary *param = @{KEY_AUTH_TOKEN : authToken};
    return param;
}

// Makes show user param for Show User API
// return param as a dictionary
+ (NSDictionary *)makeShowUserParamWithAuthToken:(NSString *)authToken {
  NSDictionary *param = @{KEY_AUTH_TOKEN : authToken};
  return param;
}

// Generate update lesson param for Update Lesson API
// Return parameter as a dictionary
+ (NSDictionary *)makeUpdateLessonParamWithLearned:(BOOL)learned
                                  resultAttributes:(NSDictionary *)resultAttribute
                                         authToken:(NSString *)authToken {
    NSDictionary *param = @{KEY_LEARNED: [NSNumber numberWithBool:learned],
                            KEY_RESULT_ATTRIBUTES: resultAttribute,
                            KEY_AUTH_TOKEN: authToken};
    return param;
}

// Generate word list param for Word List API
// Return parameter as a dictionary
+ (NSDictionary *)makeWordListParamWithCategoryId:(int)categoryId
                                           option:(NSString *)option
                                             page:(int)page
                                      perPageData:(int)perPage
                                        authToken:(NSString *)authToken {
    NSDictionary *param = @{KEY_CATEGORY_ID: [NSNumber numberWithInt:categoryId],
                            KEY_OPTION: option,
                            KEY_PAGE: [NSNumber numberWithInt:page],
                            KEY_PER_PAGE: [NSNumber numberWithInt:perPage],
                            KEY_AUTH_TOKEN : authToken};
    return param;
}

+ (NSDictionary *)makeUpdateProfileWithName:(NSString *)name
                                      email:(NSString *)email
                                   password:(NSString *)password
                       passwordConfirmation:(NSString *)passwordConfirmation
                                     avatar:(NSString *)avatarString
                                  authtoken:(NSString *)authtoken {
  NSDictionary *param = @{KEY_USER:@{KEY_NAME:name,
                                    KEY_EMAIL:email,
                                 KEY_PASSWORD:password,
                    KEY_PASSWORD_CONFIRMATION:passwordConfirmation,
                                   KEY_AVATAR:avatarString},
                                KEY_AUTH_TOKEN:authtoken};
  return param;
}

@end
