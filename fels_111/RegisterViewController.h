//
//  RegistarViewController.h
//  fels_111
//
//  Created by Md Mainul Haque on 2/18/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *registerScrollView;

- (IBAction)done:(id)sender;

- (IBAction)cancel:(id)sender;
@end
