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

+ (void)setUserToKeyChain:(User *)user {
  UICKeyChainStore *chain = [self initTheKeyChain];
  [chain setString:[NSString stringWithFormat:@"%d", user.userId] forKey:KEYCHAIN_KEY_ID];
  [chain setString:user.authToken forKey:KEYCHAIN_KEY_TOKEN];
}

+ (UICKeyChainStore *)initTheKeyChain {
  UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KEYCHAIN_KEY_SERVICE];
  return keychain;
}

@end
