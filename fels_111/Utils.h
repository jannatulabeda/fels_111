//
//  Utils.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICKeyChainStore.h"
#import "User.h"
#import "Constants.h"

@interface Utils : NSObject

+ (User *)getUserFromKeychain;
+ (void)setUserToKeyChain:(User *)user;
@end
