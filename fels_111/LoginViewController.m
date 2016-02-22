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

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
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
    [sender setSelected:NO];
  } else {
    [sender setImage:[UIImage imageNamed:CHECKED_IMAGE] forState:UIControlStateSelected];
    [sender setSelected:YES];
  }
}

- (IBAction)signInButtonPressed:(id)sender {
  [LoginManager doSignInWithEmail:self.emailLoginTextField.text
                         password:self.passwordLoginTextField.text
                         remember:YES
                      errorMessage:^(BOOL isValid, NSString *errMessage){
                        if (!isValid) {
                          self.loginErrorLabel.text = ERROR_INVALID_COMBINATION;
                        } else {
                          self.loginErrorLabel.text = errMessage;
                        }
                      }];
}
@end
