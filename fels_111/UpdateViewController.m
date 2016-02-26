//
//  UpdateViewController.m
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
  [self.updateScrollView setContentSize:size];
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

- (IBAction)updateButtonPressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
