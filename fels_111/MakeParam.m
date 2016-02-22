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
+(NSDictionary *)makeLoginParamWithEmail:(NSString *)email
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
+(NSDictionary *)makeSingUpParamWithName:(NSString *)name
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

@end
