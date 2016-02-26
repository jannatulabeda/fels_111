//
//  CategoryManager.h
//  fels_111
//
//  Created by ahammad reyad on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CategoryDelegate <NSObject>

- (void)didReceiveCategoryDataWithArray:(NSArray *)categoryArray;

@end

@interface CategoryManager : NSObject

@property (weak, nonatomic) id<CategoryDelegate> delegate;

// Get categories list
- (void)doGetCategoriesWithAuthToken:(NSString *)authToken
                          pageNumber:(int)page
                         perPageData:(int)perPageData;
@end
