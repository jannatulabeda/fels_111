//
//  LoginManager.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/22/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject

+ (void)doSignInWithEmail:(NSString *)email
                 password:(NSString *)password
                 remember:(BOOL)rememberMe
          errorMessage:(void(^)(BOOL isValid, NSString *errMessage))completeBlock;

@end
