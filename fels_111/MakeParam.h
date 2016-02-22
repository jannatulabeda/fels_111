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
+(NSDictionary *)makeLoginParamWithEmail:(NSString *)email
                           password:(NSString *)password
                         rememberMe:(BOOL)rememberMe;


// Generate sign up param for Sign up API
// Return parameter as a dictionary
+(NSDictionary *)makeSingUpParamWithName:(NSString *)name
                                   Email:(NSString *)email
                                 password:(NSString *)password
                               confirmedPassword:(NSString *)confirmedPassword;

@end
