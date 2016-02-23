//
//  CategoryTableViewCell.h
//  fels_111
//
//  Created by Jannatul on 2/23/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *learnedWordsLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
