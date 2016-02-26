//
//  UpdateViewController.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/24/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *updateScrollView;

- (IBAction)updateButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(id)sender;

@end
