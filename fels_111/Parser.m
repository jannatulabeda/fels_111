//
//  Parser.m
//  AFNetworking
//
//  Created by Jannatul on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import "Parser.h"
#import "Constants.h"

@implementation Parser

// Parse json data response for log in request
// Returns user information
-(User *)parseLoginResponse:(id)responseData {
    
    NSDictionary *logInData = [self parseJSONData:responseData];
    NSDictionary *userInfo = [logInData objectForKey:KEY_USER];
    
    User *user = [[User alloc]init];
    user.name = [userInfo objectForKey:KEY_NAME];
    user.email = [userInfo objectForKey:KEY_EMAIL];
    user.avatar = [userInfo objectForKey:KEY_AVATAR];
    user.authToken = [userInfo objectForKey:KEY_AUTH_TOKEN];
    user.learnedWords = [[userInfo objectForKey:KEY_LEARNED_WORDS] intValue];
    
    return user;
}

// Parse json data response for sign up request
// Returns success message
-(NSString *)parseSignUpResponse:(id)responseData{
    
    NSDictionary *signUpData = [self parseJSONData:responseData];
    NSString *successMessage = @"";
    if([[signUpData allKeys]containsObject:KEY_MESSAGE_RESPONSE]) {
        successMessage = [signUpData objectForKey:KEY_MESSAGE_RESPONSE];
    }
    return successMessage;
}

// Parse JSON data and returns as a dictionary
- (id)parseJSONData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            if (error != nil) {
                return nil;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

@end
