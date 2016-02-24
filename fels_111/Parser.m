//
//  Parser.m
//  AFNetworking
//
//  Created by Jannatul on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import "Parser.h"
#import "Constants.h"
#import "Answer.h"

@implementation Parser

// Parse json data response for log in request
// Returns user information
- (User *)parseLoginResponse:(id)responseData {
    
    NSDictionary *logInData = [self parseJSONData:responseData];
    NSDictionary *userInfo = [logInData objectForKey:KEY_USER];
    
    User *user = [[User alloc] init];
    user.userId = [[userInfo objectForKey:KEY_ID] intValue];
    user.name = [userInfo objectForKey:KEY_NAME];
    user.email = [userInfo objectForKey:KEY_EMAIL];
    user.avatar = [userInfo objectForKey:KEY_AVATAR];
    user.authToken = [userInfo objectForKey:KEY_AUTH_TOKEN];
    user.learnedWords = [[userInfo objectForKey:KEY_LEARNED_WORDS] intValue];
    
    return user;
}

// Parse json data response for sign up request
// Returns success message
- (NSString *)parseSignUpResponse:(id)responseData{
    
    NSDictionary *signUpData = [self parseJSONData:responseData];
    NSString *successMessage = @"";
    if([[signUpData allKeys]containsObject:KEY_MESSAGE_RESPONSE]) {
        successMessage = [signUpData objectForKey:KEY_MESSAGE_RESPONSE];
    }
    return successMessage;
}

// Parse json data response for get categories request
// Returns NSArray of categories
-(NSArray *)parseGetCategoriesResponse:(id)responseData {
    
    NSDictionary *categoriesData = [self parseJSONData:responseData];;
    NSMutableArray *categoryArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *categoryDict in [categoriesData objectForKey:KEY_CATEGORIES]) {
        
        LessonCategory *lessonCategory = [[LessonCategory alloc]init];
        lessonCategory.categoryId = [[categoryDict objectForKey:KEY_ID] intValue];
        lessonCategory.learnedWords = [[categoryDict objectForKey:KEY_LEARNED_WORDS] intValue];
        lessonCategory.categoryName = [categoryDict objectForKey:KEY_NAME];
        lessonCategory.imageURL = [categoryDict objectForKey:KEY_PHOTO];
        lessonCategory.totalPages = [[categoriesData objectForKey:KEY_TOTAL_PAGES] intValue];
        
        [categoryArray addObject:lessonCategory];
    }
    
    return categoryArray;
}

- (Lesson *)parseCreateLessonResponse:(id)responseData {
    
    NSDictionary *lessonDict = [[self parseJSONData:responseData] objectForKey:KEY_LESSON];
    
    Lesson *lessonObject = [[Lesson alloc]init];
    lessonObject.lessonId = [[lessonDict objectForKey:KEY_ID] intValue];
    lessonObject.lessonName = [lessonDict objectForKey:KEY_NAME];
    
    // Make words array
    NSArray *wordsArrayFromResponse = [lessonDict objectForKey:KEY_WORDS];
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *wordDict in wordsArrayFromResponse) {
      // Make each word object
      Word *word = [[Word alloc] init];
      word.wordContent = [wordDict objectForKey:KEY_CONTENT];
      word.wordId = [[wordDict objectForKey:KEY_ID] intValue];
      word.resultId = [wordDict objectForKey:KEY_RESULT_ID];
      
      NSArray *answersArrayFromResponse = [wordDict objectForKey:KEY_ANSWERS];
      NSMutableArray *answerArray = [[NSMutableArray alloc]init];
      for (NSDictionary *answerDict in answersArrayFromResponse) {
        //Make each answer object
        Answer *answer = [[Answer alloc] init];
        answer.answerId = [[answerDict objectForKey:KEY_ID] intValue];
        answer.answerContent = [answerDict objectForKey:KEY_CONTENT];
        answer.isCorrect = [[answerDict objectForKey:KEY_IS_CORRECT] boolValue];
        
        [answerArray addObject:answer];
      }
      word.answersArray = answerArray;
      
      [wordsArray addObject:word];
    }
    lessonObject.wordsArray = wordsArray;
    
    return lessonObject;
}

// Parse JSON data and returns as a dictionary
- (id)parseJSONData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            if (error != nil) {
                return nil;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

@end
