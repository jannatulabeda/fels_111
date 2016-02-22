//
//  DataValidation.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/16/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "DataValidation.h"
#import "DataValidation.h"
#import "Constants.h"

@implementation DataValidation

// Validate email
+ (BOOL)isValidEmailAddress:(NSString *)emailAddress errorMessage:(NSString **)errorMessage {
    
    // Check if email is empty
    if ([emailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        *errorMessage = @"Email address required";
        
        return NO;
    }
    
    // Check if valid email
    if (emailAddress.length) {
        // Create a regex string for email
        NSString *emailFilter = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        // Create predicate with format matching your regex string
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:
                                       @"SELF MATCHES %@", emailFilter];
        
        // Check if email is invalid
        if (![emailPredicate evaluateWithObject:emailAddress]) {
            *errorMessage = @"Email address is invalid";
            
            return NO;
        }
    }
    
    // Check maximum length
    if (emailAddress.length > MAX_LENGTH_EMAIL) {
        *errorMessage = [NSString stringWithFormat:@"Email can not be longer than %ld",(long)MAX_LENGTH_EMAIL];
        
        return NO;
    }
    
    return YES;
}

// Validate password
+ (BOOL)isValidPassword:(NSString *)password errorMessage:(NSString **)errorMessage {
    
    // Check if password is empty
    if ([password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        *errorMessage = @"Password required";
        
        return NO;
    }
    
    // Check minimum length
    if (password.length < MIN_LENGTH_PASSWORD) {
        *errorMessage = [NSString stringWithFormat:@"Password should be at least %ld characters long",(long)MIN_LENGTH_PASSWORD];
        
        return NO;
    }
    
    return YES;
}

// Validate user name
+ (BOOL)isValidName:(NSString *)name errorMessage:(NSString **)errorMessage {
    
    // Check if name is empty
    if ([name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        *errorMessage = @"Name required";
        
        return NO;
    }
    
    // Check maximum length
    if (name.length > MAX_LENGTH_USER_NAME) {
        *errorMessage = [NSString stringWithFormat:@"Name can not be longer than %ld",(long)MAX_LENGTH_USER_NAME];
        
        return NO;
    }
    
    return YES;
}

@end
