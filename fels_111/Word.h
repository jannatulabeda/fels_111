//
//  Word.h
//  fels_111
//
//  Created by Jannatul on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Word : NSObject

@property (strong, nonatomic) NSString *wordContent;
@property (assign, nonatomic) int wordId;
@property (strong, nonatomic) NSString *resultId;
@property (strong, nonatomic) NSArray *answersArray;
@property (strong, nonatomic) Answer *answered;
@property (assign, nonatomic) BOOL isCorrectlyAnswered;
@end
