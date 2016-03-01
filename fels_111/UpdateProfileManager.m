//
//  UpdateProfileManager.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/29/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "UpdateProfileManager.h"
#import "APIHandler.h"
#import "MakeParam.h"
#import "MakeURL.h"
#import "Utils.h"
#import "User.h"

@implementation UpdateProfileManager

+ (void)doUpdateProfileWithName:(NSString *)name
                          email:(NSString *)email
                       password:(NSString *)password
           passwordConfirmation:(NSString *)passwordConfirmation
                         avatar:(NSString *)avatarString
                      authtoken:(NSString *)authtoken
                         userID:(int)userID
                  afterComplete:(void (^)(BOOL))completeblock {
  NSDictionary *paramUpdateUser = [MakeParam
                                   makeUpdateProfileWithName:name
                                                       email:email
                                                    password:password
                                        passwordConfirmation:passwordConfirmation
                                                      avatar:avatarString
                                                   authtoken:authtoken];
  NSString *updateProfile = [MakeURL getUpdateProfileURLWithUserId:userID];
  [APIHandler patchWithUrl:updateProfile
                    params:paramUpdateUser
                   success:^(id response) {
                     completeblock(YES);
                   }
                    fail:^(NSError *error) {
                        completeblock(NO);
                      }];
}

@end
