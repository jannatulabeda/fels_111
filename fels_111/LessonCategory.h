//
//  Category.h
//  fels_111
//
//  Created by Jannatul on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonCategory : NSObject
@property (assign, nonatomic) int categoryId;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *imageURL;
@property (assign, nonatomic) int learnedWords;
@property (assign, nonatomic) int totalPages;
@end
