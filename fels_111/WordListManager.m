//
//  WordListManager.m
//  fels_111
//
//  Created by Jannatul on 3/1/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "WordListManager.h"
#import "MakeParam.h"
#import "MakeURL.h"
#import "APIHandler.h"
#import "Parser.h"

@implementation WordListManager
- (void)doGetWordListWithCategoryId:(int)categoryId
                             option:(NSString *)option
                               page:(int)page
                        perPageData:(int)perPage
                          authToken:(NSString *)authToken {
    NSDictionary *params = [MakeParam makeWordListParamWithCategoryId:categoryId
                                                           option:option page:page
                                                      perPageData:perPage
                                                        authToken:authToken];
    [APIHandler getWithUrl:[MakeURL getWordListURL] params:params
                   success:^(id response) {
                       Parser *parser = [[Parser alloc]init];
                       NSArray *wordListArray = [parser parseWordListResponse:response];
                       [self.delegate didReceiveWordListWithArray:wordListArray];
    } fail:^(NSError *error) {
        [self.delegate didReceiveWordListWithArray:nil];
    }];
}
@end
