//
//  ProfileViewController.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileManager.h"
#import "Utils.h"
#import "User.h"
#import "JTProgressHUD.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LoginViewController.h"

@interface ProfileViewController ()

@property (strong, nonatomic) NSString *emailString;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [self loadUserData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   if([segue.identifier isEqualToString:TO_LOGIN]){
     LoginViewController *controller = (LoginViewController *)segue.destinationViewController;
     controller.emailString = _emailString;
   }
}

#pragma mark - Load User Info

- (void)loadUserData {
  User *user = [[User alloc] init];
  user = [Utils getUserFromKeychain];
  [ProfileManager getShowUserWithAuthToken:user.authToken userID:user.userId
                             afterComplete:^(BOOL isOk, User *usr){
                               if (isOk) {
                                 self.userActivityArray = [[NSArray alloc] initWithArray:usr.activities];
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                   [self fillOutTheFields:usr];
                                   _emailString = usr.email;
                                   [self.userActivityTableView reloadData];
                                 });  
                               } else {
                                // TO DO
                               }
  }];
}

- (IBAction)logoutButtonPressed:(id)sender {
  [Utils clearUserFromTheKeychain];
  [self performSegueWithIdentifier:TO_LOGIN sender:self];
}

- (void)fillOutTheFields:(User *)user {
  self.userNameLabel.text = user.name;
  self.userEmailProfile.text = user.email;
  NSString *learnedWords = [NSString stringWithFormat:@"%@ %d %@", LEARNED, user.learnedWords, WORDS];
  self.numberOfLearnedWordsLabel.text = learnedWords;
  [self.userAvatarImage sd_setImageWithURL:[NSURL URLWithString:user.avatar]
                       placeholderImage:[UIImage imageNamed:AVATAR_PLACEHOLDER_IMAGE]
   options:SDWebImageRefreshCached];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.userActivityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *simpleTableIdentifier = @"User Profile Custom Cell";
  UserActivityTableViewCell *cell = (UserActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
  NSDictionary *activity = [self.userActivityArray objectAtIndex:indexPath.row];
  cell.activityContentLabel.text = [activity valueForKey:KEY_CONTENT];
  
  return cell;
}

@end
