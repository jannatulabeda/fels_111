//
//  RegistarViewController.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/18/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

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
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
