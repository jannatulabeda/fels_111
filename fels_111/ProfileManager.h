//
//  ProfileManager.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/26/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ProfileManager : NSObject

+ (void)getShowUserWithAuthToken:(NSString *)authToken
                          userID:(int) userId afterComplete:(void(^)(BOOL isOk, User *user))completeblock;

@end
