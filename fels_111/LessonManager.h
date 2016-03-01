//
//  LessonManager.h
//  fels_111
//
//  Created by ahammad reyad on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lesson.h"

@protocol LessonDelegate <NSObject>

- (void)didReceiveLessonObject:(Lesson *)lesson;
- (void)didReceiveUpdateLessonResponseWithBool:(BOOL)isSuccess;

@end

@interface LessonManager : NSObject

@property (weak, nonatomic) id<LessonDelegate> delegate;

- (void)doGetLessonWithCategoryId:(int)categoryId authToken:(NSString *)authToken;
- (void)doUpdateLessonWithAuthToken:(NSString *)authToken
                         lessonId:(int)lessonId
                           resutlId:(int)resultId
                           answerId:(int)answerId;
@end
