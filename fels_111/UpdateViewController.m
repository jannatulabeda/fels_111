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
#import <SDWebImage/UIImageView+WebCache.h>
#import "Constants.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
  [self.updateScrollView setContentSize:size];
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  User *user = [[User alloc] init];
  user = [Utils getUserFromKeychainWithNameWithEmailWithAvatar];
  self.updateFullNameTextField.text = user.name;
  self.updateEmailTextField.text = user.email;
  [self.updateAvatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]
                                placeholderImage:[UIImage imageNamed:AVATAR_PLACEHOLDER_IMAGE]];
  self.updateOldPasswordTextField.userInteractionEnabled = NO;
  
  [self.updateAvatarImageView setUserInteractionEnabled:YES];
  UITapGestureRecognizer *tapOnAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnAvatarAction:)];
  [self.updateAvatarImageView addGestureRecognizer:tapOnAvatar];
  
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

- (void)tapOnAvatarAction:(UITapGestureRecognizer *)tapOnAvatar {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:TITLE_AVATAR message:TITLE_AVATAR_MESSAGE preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:TITLE_CANCEL
                                                   style:UIAlertActionStyleDestructive
                                                 handler:^(UIAlertAction *action) {
                                                 }];
  UIAlertAction *gallery = [UIAlertAction actionWithTitle:TITLE_GALLERY style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self chooseFromGallery];
  }];
  UIAlertAction *camera = [UIAlertAction actionWithTitle:TITLE_CAMERA style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self takePhoto];
  }];
  
  [alert addAction:camera];
  [alert addAction:gallery];
  [alert addAction:cancel];
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)chooseFromGallery {
  self.avatarPicker = [[UIImagePickerController alloc] init];
  self.avatarPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  self.avatarPicker.delegate = self;
  [self presentViewController:self.avatarPicker animated:YES completion:nil];
}

- (void)takePhoto {
  if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
    UIAlertController *cameraErrorAlert = [UIAlertController alertControllerWithTitle:TITLE_CAMERA_ERROR message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraNotFound = [UIAlertAction actionWithTitle:TITLE_CAMERA_UNAVAILABLE_ERROR style:UIAlertActionStyleDestructive handler:nil];
    
    [cameraErrorAlert addAction:cameraNotFound];
    [self presentViewController:cameraErrorAlert animated:YES completion:nil];
  } else {
    self.avatarPicker = [[UIImagePickerController alloc] init];
    self.avatarPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.avatarPicker.delegate = self;
    [self presentViewController:self.avatarPicker animated:YES completion:nil];
  }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
  
  // Resizing the image with respect to
  // ImageViews Frame
  CGSize viewSize = CGSizeMake(self.updateAvatarImageView.frame.size.width, self.updateAvatarImageView.frame.size.height);
  
  UIGraphicsBeginImageContext(viewSize);
  [chosenImage drawInRect:CGRectMake(0,0,viewSize.width,viewSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  NSData *imgData = UIImagePNGRepresentation(newImage);
  [self.updateAvatarImageView setImage:[[UIImage alloc] initWithData:imgData]];
  [picker dismissViewControllerAnimated:YES completion:nil];

}

- (NSString *)encodeToBase64String:(UIImage *)image {
  return [UIImageJPEGRepresentation(image,0.4) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

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
    self.avatarString = @"";
    if (self.updateAvatarImageView.image) {
      self.avatarString = [self encodeToBase64String:self.updateAvatarImageView.image];
    }
    [JTProgressHUD show];
    [UpdateProfileManager doUpdateProfileWithName:self.updateFullNameTextField.text
                                            email:self.updateEmailTextField.text
                                         password:self.updateNewPasswordTextField.text
                             passwordConfirmation:self.updateReTypePasswordTextField.text
                                           avatar:self.avatarString
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

