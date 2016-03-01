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

@interface ProfileViewController ()

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadUserData {
  User *user = [[User alloc] init];
  user = [Utils getUserFromKeychain];
  [JTProgressHUD show];
  [ProfileManager getShowUserWithAuthToken:user.authToken userID:user.userId
                             afterComplete:^(BOOL isOk, User *usr){
                               if (isOk) {
                                 [JTProgressHUD hide];
                                 self.userActivityArray = [[NSArray alloc] initWithArray:usr.activities];
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                   [self fillOutTheFields:usr];
                                   [self.userActivityTableView reloadData];
                                 });
                               } else {
                                // TO DO
                               }
  }];
}

- (IBAction)logoutButtonPressed:(id)sender {
  [self performSegueWithIdentifier:TO_LOGIN sender:self];
}

- (void)fillOutTheFields:(User *)user {
  self.userNameLabel.text = user.name;
  self.userEmailProfile.text = user.email;
  NSString *learnedWords = [NSString stringWithFormat:@"%@ %d %@", LEARNED, user.learnedWords, WORDS];
  self.numberOfLearnedWordsLabel.text = learnedWords;
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
