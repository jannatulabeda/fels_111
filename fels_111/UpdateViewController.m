//
//  UpdateViewController.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "UpdateViewController.h"
#import "DataValidation.h"
#import "JTProgressHUD.h"
#import "Utils.h"
#import "User.h"
#import "UpdateProfileManager.h"


@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
  [self.updateScrollView setContentSize:size];
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  User *user = [[User alloc] init];
  user = [Utils getUserFromKeychainWithNameAndEmail];
  self.updateFullNameTextField.text = user.name;
  self.updateEmailTextField.text = user.email;
  self.updateOldPasswordTextField.userInteractionEnabled = NO;
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

- (IBAction)updateButtonPressed:(id)sender {
  
  NSString *errorString;
  BOOL isValidEmail = [DataValidation isValidEmailAddress:self.updateEmailTextField.text errorMessage:&errorString];
  BOOL isValidPassword = [DataValidation isValidPassword:self.updateNewPasswordTextField.text errorMessage:&errorString];
  BOOL isValidName = [DataValidation isValidName:self.updateFullNameTextField.text errorMessage:&errorString];
  
  if ([self.updateEmailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
    isValidEmail = YES;
  }
  
  if ([self.updateNewPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
    isValidPassword = YES;
  }
  
  if ([self.updateFullNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
    isValidPassword = YES;
  }
  
  if (isValidEmail && isValidPassword && isValidName) {    
    User *user = [[User alloc] init];
    user = [Utils getUserFromKeychain];
    [JTProgressHUD show];
    [UpdateProfileManager doUpdateProfileWithName:self.updateFullNameTextField.text
                                            email:self.updateEmailTextField.text
                                         password:self.updateNewPasswordTextField.text
                             passwordConfirmation:self.updateReTypePasswordTextField.text
                                           avatar:@""
                                        authtoken:user.authToken
                                           userID:user.userId
                                    afterComplete:^(BOOL isOK){
                                      if (isOK) {
                                        [JTProgressHUD hide];
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                      } else {
                                        [JTProgressHUD hide];
                                      }
          }];
  } else {
    self.updateErrorLabel.text = errorString;
  }
  
}

- (IBAction)cancelButtonPressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
