//
//  UpdateViewController.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *updateEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *updateOldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *updateNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *updateReTypePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *updateFullNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *updateAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *updateErrorLabel;
@property (strong, nonatomic) UIImagePickerController *avatarPicker;
@property (strong, nonatomic) NSString *avatarString;

@property (weak, nonatomic) IBOutlet UIScrollView *updateScrollView;

- (IBAction)updateButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(id)sender;

@end
