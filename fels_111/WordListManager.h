//
//  WordListManager.h
//  fels_111
//
//  Created by Jannatul on 3/1/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WordListDelegate <NSObject>

- (void)didReceiveWordListWithArray:(NSArray *)wordsArray;

@end
@interface WordListManager : NSObject
@property (weak, nonatomic) id<WordListDelegate> delegate;
- (void)doGetWordListWithCategoryId:(int)categoryId
                             option:(NSString *)option
                               page:(int)page
                        perPageData:(int)perPage
                          authToken:(NSString *)authToken;
@end
