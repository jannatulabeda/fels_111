//
//  LessonViewController.m
//  fels_111
//
//  Created by Jannatul on 2/23/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "LessonViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultTableViewController.h"
@interface LessonViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *answerButton1;
@property (weak, nonatomic) IBOutlet UIButton *answerButton2;
@property (weak, nonatomic) IBOutlet UIButton *answerButton3;
@property (weak, nonatomic) IBOutlet UIButton *answerButton4;

@end

@implementation LessonViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setTitle:self.pageTitle];
    [self setContentView];
    [self setButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Set QuestionView
-(void) setContentView {
    [[self.contentView layer] setBorderWidth:1.0f];
    [[self.contentView layer] setBorderColor:[UIColor blackColor].CGColor];
}

// Set Button
-(void) setButtons {
    
    // Set buttons border
    [[self.answerButton1 layer] setBorderWidth:1.0f];
    [[self.answerButton1 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.answerButton2 layer] setBorderWidth:1.0f];
    [[self.answerButton2 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.answerButton3 layer] setBorderWidth:1.0f];
    [[self.answerButton3 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.answerButton4 layer] setBorderWidth:1.0f];
    [[self.answerButton4 layer] setBorderColor:[UIColor blackColor].CGColor];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
