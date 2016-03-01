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
#import "Lesson.h"

@interface Parser : NSObject

// Parse json data response for log in request
// Returns user information
- (User *)parseLoginResponse:(id)responseData;

// Parse json data response for sign up request
// Returns success message
-(NSString *)parseSignUpResponse:(id)responseData;

// Parse json data response for get categories request
// Returns NSArray of categories
-(NSArray *)parseGetCategoriesResponse:(id)responseData;

// Parse json data response for create lesson request
// Returns NSArray of words
- (Lesson *)parseCreateLessonResponse:(id)responseData;

// Parse json data response for show user request
// Returns User information
- (User *)parseShowUserResponse:(id)responseData;

// Parse json data response for word list request
// Returns words array 
- (NSArray *)parseWordListResponse:(id)responseData;
@end
