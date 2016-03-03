//
//  Utils.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (User *)getUserFromKeychain {
  UICKeyChainStore *chain = [self initTheKeyChain];
  User *user = [[User alloc] init];
  user.userId = chain[KEYCHAIN_KEY_ID].intValue;
  user.authToken = chain[KEYCHAIN_KEY_TOKEN];
  return user;
}

+ (User *)getUserFromKeychainWithNameWithEmailWithAvatar {
  UICKeyChainStore *chain = [self initTheKeyChain];
  User *user = [[User alloc] init];
  user = [self getUserFromKeychain];
  user.name = chain[KEYCHAIN_KEY_NAME];
  user.email = chain[KEYCHAIN_KEY_EMAIL];
  user.avatar = chain[KEYCHAIN_KEY_AVATAR];
  return user;
}

+ (void)setUserToKeyChain:(User *)user {
  UICKeyChainStore *chain = [self initTheKeyChain];
  [chain setString:[NSString stringWithFormat:@"%d", user.userId] forKey:KEYCHAIN_KEY_ID];
  [chain setString:user.authToken forKey:KEYCHAIN_KEY_TOKEN];
  [chain setString:user.name forKey:KEYCHAIN_KEY_NAME];
  [chain setString:user.email forKey:KEYCHAIN_KEY_EMAIL];
  [chain setString:user.avatar forKey:KEYCHAIN_KEY_AVATAR];
}

+ (void)setRememberMeToKeychain:(BOOL)rememberMe {
  UICKeyChainStore *chain = [self initTheKeyChain];
  [chain setString:(rememberMe ? @"YES" : @"NO") forKey:KEYCHAIN_KEY_REMEMBERED];
}

+ (BOOL)getRemeberMeToKeychain {
  UICKeyChainStore *chain = [self initTheKeyChain];
  return chain[KEYCHAIN_KEY_REMEMBERED].boolValue;
}

+ (UICKeyChainStore *)initTheKeyChain {
  UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KEYCHAIN_KEY_SERVICE];
  return keychain;
}

// Show error message with UIAlertController
+ (void)showErrorMessageWithTitle:(NSString *)title
                          message:(NSString *)message
                   viewController:(UIViewController *)viewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)clearUserFromTheKeychain {
  UICKeyChainStore *chain = [self initTheKeyChain];
  [chain removeItemForKey:KEYCHAIN_KEY_TOKEN];
  [chain removeItemForKey:KEYCHAIN_KEY_ID];
  [chain removeItemForKey:KEYCHAIN_KEY_NAME];
  [chain removeItemForKey:KEYCHAIN_KEY_EMAIL];
  [chain removeItemForKey:KEYCHAIN_KEY_REMEMBERED];
}
@end
