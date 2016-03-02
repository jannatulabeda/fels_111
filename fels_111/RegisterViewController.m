//
//  RegistarViewController.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/18/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterManager.h"
#import "Utils.h"
#import "JTProgressHUD.h"
#import "Constants.h"

@interface RegisterViewController ()<RegisterDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Setting the scrollview content size
  CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
  [self.registerScrollView setContentSize:size];
  self.automaticallyAdjustsScrollViewInsets = NO;
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

- (IBAction)done:(id)sender {
  [JTProgressHUD show];
  RegisterManager *registerManager = [[RegisterManager alloc] init];
  registerManager.delegate = self;
  [registerManager doSignUpWithEmail:_registerEmailTextField.text name:_registerNameTextField.text password:_registerPasswordTextField.text confirmedPassword:_registerReTypePasswordTextField.text];
  
}

- (void)didReceiveRegisterResponseWithUser:(User *)user errorMessage:(NSString *)errorMessage {
  if (user) {
    [JTProgressHUD hide];
    [self performSegueWithIdentifier:TO_PROFILE_FROM_REGISTER sender:self];
  } else {
    if (errorMessage) {
      _registerUserInfoLabel.text = errorMessage;
      [JTProgressHUD hide];
    }
  }
}

- (IBAction)cancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
