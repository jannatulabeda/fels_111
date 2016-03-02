//
//  ProfileManager.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/26/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "ProfileManager.h"
#import "MakeParam.h"
#import "MakeURL.h"
#import "APIHandler.h"
#import "JTProgressHUD.h"
#import "Parser.h"

@implementation ProfileManager

+ (void)getShowUserWithAuthToken:(NSString *)authToken
                          userID:(int)userId
                   afterComplete:(void (^)(BOOL isOK, User *user))completeblock{
  NSDictionary *paramShowUser = [MakeParam makeShowUserParamWithAuthToken:authToken];
  NSString *showUserURL = [MakeURL getShowUserProfileURLWithUserId:userId];
  [JTProgressHUD show];
  [APIHandler getWithUrl:showUserURL params:paramShowUser
                 success:^(id response){
                   if (response != nil) {
                     [JTProgressHUD hide];
                     User *usr = [[User alloc] init];
                     Parser *parserShowUser = [[Parser alloc] init];
                     usr = [parserShowUser parseShowUserResponse:response];
                     completeblock(YES,usr);
                   }
  } fail:^(NSError *error) {
    [JTProgressHUD hide];
    completeblock(NO,nil);
  }];
}

@end
