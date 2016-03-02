//
//  RegisterManager.m
//  fels_111
//
//  Created by Jannatul on 2/29/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "RegisterManager.h"
#import "DataValidation.h"
#import "Utils.h"
#import "MakeParam.h"
#import "APIHandler.h"
#import "MakeURL.h"
#import "Parser.h"

@implementation RegisterManager
// Do sign up
- (void)doSignUpWithEmail:(NSString *)email
                     name:(NSString *)name
                 password:(NSString *)password
        confirmedPassword:(NSString *)confirmedPassword {
  NSString *errorMessage = @"";
  // Check if the register data is correct
  if (![self checkRegisterInformationWithEmail:email
                                          name:name
                                      password:password
                             confirmedPassword:confirmedPassword
                                  errorMessage:&errorMessage]) {
    [self.delegate didReceiveRegisterResponseWithUser:nil errorMessage:errorMessage];
    return;
  }
  // Send API request for sign up
  [self sendSignUpRequestWithEmail:email
                              name:name
                          password:password
                 confirmedPassword:confirmedPassword];
}

// Check if information for registration is correct
- (BOOL)checkRegisterInformationWithEmail:(NSString *)email
                                     name:(NSString *)name
                                 password:(NSString *)password
                        confirmedPassword:(NSString *)confirmedPassword
                             errorMessage:(NSString **)errorMessage {
  // Check if email address is correct
  if (![DataValidation isValidEmailAddress:email errorMessage:errorMessage]) {
    return NO;
  }
  // Check if password is correct
  if (![DataValidation isValidPassword:password errorMessage:errorMessage]) {
    
    return NO;
  }
  // Check if confirmed password is correct
  if (![DataValidation isValidPassword:confirmedPassword errorMessage:errorMessage]) {
    return NO;
  } else {
    // If passwords do not match
    if (![password isEqualToString:confirmedPassword]) {
      *errorMessage = @"Passwords do not match.";
      return NO;
    }
  }
  // Check if name is correct
  if (![DataValidation isValidName:name errorMessage:errorMessage]) {
    return NO;
  }
  return YES;
}

// Send sign up request to server
- (void)sendSignUpRequestWithEmail:(NSString *)email
                              name:(NSString *)name
                          password:(NSString *)password
                 confirmedPassword:(NSString *)confirmedPassword {
  NSDictionary *param = [MakeParam makeSingUpParamWithName:name
                                                     Email:email
                                                  password:password
                                         confirmedPassword:confirmedPassword];
  [APIHandler postWithUrl:[MakeURL getSignUpURL]
                   params:param success:^(id response) {
                     //Show success message
                     User *user = [[User alloc] init];
                     Parser *parserLogin = [[Parser alloc] init];
                     user = [parserLogin parseLoginResponse:response];
                     [Utils setUserToKeyChain:user];
                     [self.delegate didReceiveRegisterResponseWithUser:user errorMessage:nil];
                     // Send profile update request
                     // Need to implement after profile update page is done
                   } fail:^(NSError *error) {
                     // Form the error message from the error message
                     NSData *data = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                     NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];\
                     if ([[responseDict allKeys]containsObject:KEY_MESSAGE_RESPONSE]) {
                       NSString *errorMessage = @"";
                       if ([[responseDict objectForKey:KEY_MESSAGE_RESPONSE] isKindOfClass:[NSDictionary class]]) {
                         NSDictionary *messageDict = [responseDict objectForKey:KEY_MESSAGE_RESPONSE];
                         for (NSString *key in [messageDict allKeys]) {
                           NSArray *arrayMessage = [messageDict objectForKey:key];
                           for (NSString *msg in arrayMessage) {
                             errorMessage = [NSString stringWithFormat:@"%@ %@", key, msg];
                           }
                         }
                       } else if ([[responseDict objectForKey:KEY_MESSAGE_RESPONSE] isKindOfClass:[NSString class]]){
                         errorMessage = [responseDict objectForKey:KEY_MESSAGE_RESPONSE];
                       }
                       [self.delegate didReceiveRegisterResponseWithUser:nil errorMessage:errorMessage];
                     }
                   }];
}

@end
