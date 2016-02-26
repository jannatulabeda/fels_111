//
//  DataValidation.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/16/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataValidation : NSObject

// Validate email
+ (BOOL)isValidEmailAddress:(NSString *)emailAddress errorMessage:(NSString **)errorMessage;

// Validate password
+ (BOOL)isValidPassword:(NSString *)password errorMessage:(NSString **)errorMessage;

// Validate user name
+ (BOOL)isValidName:(NSString *)name errorMessage:(NSString **)errorMessage;

@end
