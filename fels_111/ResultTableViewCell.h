//
//  LessonTableViewCell.h
//  fels_111
//
//  Created by Jannatul on 2/23/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
