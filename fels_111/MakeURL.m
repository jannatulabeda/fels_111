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

@end
