//
//  Utils.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICKeyChainStore.h"
#import "User.h"
#import "Constants.h"
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (User *)getUserFromKeychain;
+ (User *)getUserFromKeychainWithNameAndEmail;
+ (void)setUserToKeyChain:(User *)user;
+ (void)setRememberMeToKeychain:(BOOL)rememberMe;
+ (BOOL)getRemeberMeToKeychain;
+ (void)clearUserFromTheKeychain;

// Show error message with UIAlertController
+ (void)showErrorMessageWithTitle:(NSString *)title
                          message:(NSString *)message
                   viewController:(UIViewController *)viewController;
@end
