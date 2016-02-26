//
//  LoginManager.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/22/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "LoginManager.h"
#import "DataValidation.h"
#import "APIHandler.h"
#import "MakeParam.h"
#import "MakeURL.h"
#import "Parser.h"
#import "Utils.h"
#import "JTProgressHUD.h"

@implementation LoginManager

+ (void)doSignInWithEmail:(NSString *)email
                 password:(NSString *)password
                 remember:(BOOL)rememberMe
          errorMessage:(void(^)(BOOL isValid, NSString *errMessage))completeBlock{
  NSString *errorMessage = @"";
  [self checkLoginInformationWithEmail:email password:password errorMessage:&errorMessage];
  
  if ([errorMessage isEqualToString:@""]) {
    NSDictionary *paramLogin = [[NSDictionary alloc]
                                initWithDictionary:[MakeParam makeLoginParamWithEmail:email password:password rememberMe:rememberMe]];
    NSString *urlLogin = [[NSString alloc] initWithString:[MakeURL getLogInURL]];
    [JTProgressHUD show];
    [APIHandler postWithUrl:urlLogin params:paramLogin success:^(id response) {
      if (response != nil) {
        User *user = [[User alloc] init];
        Parser *parserLogin = [[Parser alloc] init];
        user = [parserLogin parseLoginResponse:response];
        [Utils setUserToKeyChain:user];
        [JTProgressHUD hide];
        completeBlock(YES,@"");
      }
    } fail:^(NSError *error) {
      completeBlock(NO,@"");
    }];
  } else {
    completeBlock(YES,errorMessage);
  }
}

+ (BOOL)checkLoginInformationWithEmail:(NSString *)email
                               password:(NSString *)password errorMessage:(NSString **)errorMessage
{
  // Check if email address is correct
  if (![DataValidation isValidEmailAddress:email errorMessage:errorMessage]) {
    return NO;
  }
  
  // Check if password is correct
  if (![DataValidation isValidPassword:password errorMessage:errorMessage]) {
    return NO;
  }
  
  // Check if confirmed password is correct
  if (![DataValidation isValidPassword:password errorMessage:errorMessage]) {
    return NO;
  }
  return YES;
}
@end
