//
//  Parser.h
//  AFNetworking
//
//  Created by Jannatul on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "LessonCategory.h"

@interface Parser : NSObject

// Parse json data response for log in request
// Returns user information
-(User *)parseLoginResponse:(id)responseData;

// Parse json data response for sign up request
// Returns success message
-(NSString *)parseSignUpResponse:(id)responseData;

// Parse json data response for get categories request
// Returns NSArray of categories
-(NSArray *)parseGetCategoriesResponse:(id)responseData;
@end
