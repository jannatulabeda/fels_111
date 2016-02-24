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
#import "LessonManager.h"
#import "Answer.h"
#import "JTProgressHUD.h"

@interface LessonViewController () <LessonDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *answerButton1;
@property (weak, nonatomic) IBOutlet UIButton *answerButton2;
@property (weak, nonatomic) IBOutlet UIButton *answerButton3;
@property (weak, nonatomic) IBOutlet UIButton *answerButton4;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordContentLabel;

@property (strong, nonatomic) Lesson *lesson;
@property (strong, nonatomic) NSMutableArray *wordsArray;
@end

@implementation LessonViewController {
    int countWord;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setTitle:_category.categoryName];
    [self setContentView];
    [self setButtonsUI];
    
    [JTProgressHUD show];
    LessonManager *lessonManager = [[LessonManager alloc] init];
    lessonManager.delegate = self;
    
    // Authentication token will be added later
    [lessonManager doGetLessonWithCategoryId:_category.categoryId authToken:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Set contentView
- (void)setContentView {
    [[self.contentView layer] setBorderWidth:1.0f];
    [[self.contentView layer] setBorderColor:[UIColor blackColor].CGColor];
}

// Set Button
- (void)setButtonsUI {
    
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

// Load question and answer in the UI
- (void)loadNextQuestionAndAnswers {
    
    countWord ++;
    [self.wordCountLabel setText:[NSString stringWithFormat:@"%i/%lu", countWord, (unsigned long)[self.wordsArray count]]];
    
    Word *word = [self.wordsArray objectAtIndex:countWord-1];
    self.wordContentLabel.text = word.wordContent;
    
    Answer *answer = [word.answersArray objectAtIndex:0];
    [self.answerButton1 setTitle:answer.answerContent forState:UIControlStateNormal];
    
    answer = [word.answersArray objectAtIndex:1];
    [self.answerButton2 setTitle:answer.answerContent forState:UIControlStateNormal];
    
    answer = [word.answersArray objectAtIndex:2];
    [self.answerButton3 setTitle:answer.answerContent forState:UIControlStateNormal];
    
    answer = [word.answersArray objectAtIndex:3];
    [self.answerButton4 setTitle:answer.answerContent forState:UIControlStateNormal];
}

#pragma mark - Button action
- (IBAction)answerButtonPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    Word *word = [self.wordsArray objectAtIndex:countWord-1];
    
    word.answered = [word.answersArray objectAtIndex:button.tag - 1];
    word.isCorrectlyAnswered = word.answered.isCorrect ? YES : NO;
    
    [self.wordsArray replaceObjectAtIndex:countWord-1 withObject:word];
    
    if(countWord < [self.wordsArray count]) {
        [self loadNextQuestionAndAnswers];
    }
    
    if (countWord == [self.wordsArray count]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Lesson finished"
                                                                                 message:@"Please press done to see the result"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // If navigating to LessonViewController
    if ([[segue identifier] isEqualToString:@"toResultSegue"]) {
        // Generate result
    }
}


#pragma mark - LessonDelegate

- (void)didReceiveLessonObject:(Lesson *)lesson {
    
    [JTProgressHUD hide];
    self.lesson = lesson;
    self.wordsArray = lesson.wordsArray;
    [self loadNextQuestionAndAnswers];
}

@end
