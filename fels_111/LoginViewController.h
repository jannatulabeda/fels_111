//
//  ViewController.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/16/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailLoginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordLoginTextField;
@property (weak, nonatomic) IBOutlet UILabel *loginErrorLabel;
@property (assign, nonatomic) BOOL rememberMeChecked;

- (IBAction)toggleRememberMeButtonImage:(id)sender;

- (IBAction)signInButtonPressed:(id)sender;

@end

