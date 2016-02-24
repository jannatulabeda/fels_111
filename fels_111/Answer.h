//
//  Answer.h
//  fels_111
//
//  Created by Jannatul on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (strong, nonatomic) NSString *answerContent;
@property (assign, nonatomic) int answerId;
@property (assign, nonatomic) BOOL isCorrect;

@end
