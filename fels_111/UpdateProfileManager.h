//
//  UpdateProfileManager.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/29/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateProfileManager : NSObject

+ (void)doUpdateProfileWithName:(NSString *)name
                          email:(NSString *)email
                       password:(NSString *)password
           passwordConfirmation:(NSString *)passwordConfirmation
                         avatar:(NSString *)avatarString 
                      authtoken:(NSString *)authtoken
                         userID:(int)userID
                  afterComplete:(void(^)(BOOL isOK))completeblock;

@end
