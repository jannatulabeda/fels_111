//
//  User.h
//  AFNetworking
//
//  Created by Jannatul on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *authToken;
@property (assign, nonatomic) int learnedWords;
@end
