//
//  RegisterManager.h
//  fels_111
//
//  Created by Jannatul on 2/29/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@protocol RegisterDelegate <NSObject>
- (void)didReceiveRegisterResponseWithUser:(User *)user errorMessage:(NSString *)errorMessage;
@end

@interface RegisterManager : NSObject
@property (weak, nonatomic) id<RegisterDelegate> delegate;
// Do sign up
- (void) doSignUpWithEmail:(NSString *)email
                      name:(NSString *)name
                  password:(NSString *)password
         confirmedPassword:(NSString *)confirmedPassword;
@end
