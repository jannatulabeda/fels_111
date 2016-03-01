//
//  LessonManager.m
//  fels_111
//
//  Created by ahammad reyad on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "LessonManager.h"
#import "MakeURL.h"
#import "MakeParam.h"
#import "APIHandler.h"
#import "Parser.h"
#import "Constants.h"

@implementation LessonManager

- (void)doGetLessonWithCategoryId:(int)categoryId authToken:(NSString *)authToken {
    NSString *url = [MakeURL getCreateLessonURLWithCategoryId:categoryId];
    NSDictionary *param = [MakeParam makeCreateLessonParamWithAuthToken:authToken];
    [APIHandler postWithUrl:url params:param success:^(id response) {
        Parser *parser = [[Parser alloc]init];
        Lesson *lesson = [parser parseCreateLessonResponse:response];
        [_delegate didReceiveLessonObject:lesson];
    } fail:^(NSError *error) {
    }];
}

- (void)doUpdateLessonWithAuthToken:(NSString *)authToken
                         lessonId:(int)lessonId
                           resutlId:(int)resultId
                           answerId:(int)answerId {
    NSString *updateLessonURL = [MakeURL getUpdateLessonURLWithLessonId:lessonId];
    NSDictionary *resultAttributes = @{KEY_ID: [NSNumber numberWithInt:resultId],
                                       KEY_ANSWER_ID: [NSNumber numberWithInt:answerId]};
    NSDictionary *param = [MakeParam makeUpdateLessonParamWithLearned:YES
                                                     resultAttributes:resultAttributes
                                                            authToken:authToken];
    [APIHandler patchWithUrl:updateLessonURL
                      params:param
                     success:^(id response) {
                         [self.delegate didReceiveUpdateLessonResponseWithBool:YES];
                     } fail:^(NSError *error) {
                         [self.delegate didReceiveUpdateLessonResponseWithBool:YES];
                     }];
}

@end
