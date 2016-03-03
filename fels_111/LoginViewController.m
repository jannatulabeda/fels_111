//
//  ViewController.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/16/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "LoginManager.h"
#import "Utils.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self checkRememberMe];
}

-(void)viewWillAppear:(BOOL)animated {
  [self clearFieldData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}

- (IBAction)toggleRememberMeButtonImage:(id)sender {
  if ([sender isSelected]) {
    [sender setImage:[UIImage imageNamed:UNCHECKED_IMAGE] forState:UIControlStateNormal];
    self.rememberMeChecked = NO;
    [sender setSelected:NO];
  } else {
    [sender setImage:[UIImage imageNamed:CHECKED_IMAGE] forState:UIControlStateSelected];
    self.rememberMeChecked = YES;
    [sender setSelected:YES];
  }
}

- (IBAction)signInButtonPressed:(id)sender {
  [LoginManager doSignInWithEmail:self.emailLoginTextField.text
                         password:self.passwordLoginTextField.text
                         remember:self.rememberMeChecked
                      errorMessage:^(BOOL isValid, NSString *errMessage){
                        if (!isValid) {
                          self.loginErrorLabel.text = ERROR_INVALID_COMBINATION;
                        } else {
                          if ([errMessage  isEqualToString:@""]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                              [self performSegueWithIdentifier:@"ToProfile" sender:self];
                              [self clearFieldData];
                            });
                          } else {
                            self.loginErrorLabel.text = errMessage;
                          }
                        }
                      }];
}

- (void)clearFieldData {
  self.emailLoginTextField.text = @"";
  self.passwordLoginTextField.text = @"";
  self.loginErrorLabel.text = @"";
}

- (void)checkRememberMe {
  if ([Utils getRemeberMeToKeychain]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self performSegueWithIdentifier:@"ToProfile" sender:self];
    });
  }
}
@end
