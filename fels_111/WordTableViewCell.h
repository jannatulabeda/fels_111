//
//  WordTableViewCell.h
//  fels_111
//
//  Created by Jannatul on 3/2/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wordContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerContentLabel;
@end
