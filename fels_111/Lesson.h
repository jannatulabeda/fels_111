//
//  Lesson.h
//  fels_111
//
//  Created by Jannatul on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@interface Lesson : NSObject

@property (assign, nonatomic) int lessonId;
@property (strong, nonatomic) NSString *lessonName;
@property (strong, nonatomic) NSMutableArray *wordsArray;

@end
