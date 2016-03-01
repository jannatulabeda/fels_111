//
//  ProfileViewController.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserActivityTableViewCell.h"

@interface ProfileViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailProfile;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLearnedWordsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImage;
@property (weak, nonatomic) IBOutlet UITableView *userActivityTableView;
@property (strong, nonatomic) NSArray *userActivityArray;

- (IBAction)logoutButtonPressed:(id)sender;

@end
