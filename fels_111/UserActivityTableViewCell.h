//
//  UserActivityTableViewCell.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/26/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *activityContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityCreatedDate;

@end
