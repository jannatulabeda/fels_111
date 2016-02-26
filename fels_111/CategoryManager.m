//
//  CategoryManager.m
//  fels_111
//
//  Created by ahammad reyad on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "CategoryManager.h"
#import "MakeParam.h"
#import "MakeURL.h"
#import "APIHandler.h"
#import "User.h"
#import "Parser.h"

@implementation CategoryManager

// Get categories list
- (void)doGetCategoriesWithAuthToken:(NSString *)authToken
                          pageNumber:(int)page
                         perPageData:(int)perPageData {
    
    // Send Get Categories API request
    NSDictionary *param = [MakeParam makeCategoryParamWithPage:page
                                                       perPage:perPageData
                                                     authToken:authToken];
    [APIHandler getWithUrl:[MakeURL getCategoriesURL] params:param success:^(id response) {
        Parser *parser = [[Parser alloc]init];
        NSArray *array = [parser parseGetCategoriesResponse:response];
        [self.delegate didReceiveCategoryDataWithArray:array];
    } fail:^(NSError *error) {
        
    }];
}

@end
