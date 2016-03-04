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
#import "Utils.h"
#import "User.h"
#import "ResultTableViewController.h"

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
    
    // Send request for create lesson
    [JTProgressHUD show];
    LessonManager *lessonManager = [[LessonManager alloc] init];
    lessonManager.delegate = self;
    User *user = [Utils getUserFromKeychain];
    [lessonManager doGetLessonWithCategoryId:_category.categoryId authToken:user.authToken];
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

// Set Buttons UI
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
    if (countWord >= [self.wordsArray count]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Lesson finished"
                                                                                 message:@"Press OK to see the result."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *lessonStoryboard = [UIStoryboard storyboardWithName:@"Lesson" bundle: nil];
            ResultTableViewController *resultTableViewController = [lessonStoryboard instantiateViewControllerWithIdentifier:@"ResultTableViewController"];
            resultTableViewController.lesson = self.lesson;
            [self.navigationController pushViewController:resultTableViewController animated:YES];
        }];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    countWord ++;
    [self.wordCountLabel setText:[NSString stringWithFormat:@"%i/%lu", countWord, (unsigned long)[self.wordsArray count]]];
    // Set word content
    Word *word = [self.wordsArray objectAtIndex:countWord-1];
    self.wordContentLabel.text = word.wordContent;
    
    // Set answers in the buttons
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
    // Update word object with answer and correctly answered bool value
    word.answered = [word.answersArray objectAtIndex:button.tag - 1];
    word.isCorrectlyAnswered = word.answered.isCorrect ? YES : NO;
    [self.wordsArray replaceObjectAtIndex:countWord-1 withObject:word];
    [self loadNextQuestionAndAnswers];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Load next word and answers
        // Send request for create lesson
        LessonManager *lessonManager = [[LessonManager alloc] init];
        lessonManager.delegate = self;
        User *user = [Utils getUserFromKeychain];
        [lessonManager doUpdateLessonWithAuthToken:user.authToken
                                          lessonId:[self.lesson lessonId]
                                          resutlId:[word.resultId intValue]
                                          answerId:[word.answered answerId]];
    });
}

- (IBAction)nextButtonPressed:(id)sender {
    [self loadNextQuestionAndAnswers];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // If navigating to LessonViewController
    if ([[segue identifier] isEqualToString:@"toResultSegue"]) {
        // Send result to result page
        ResultTableViewController *resultTableViewController = [segue destinationViewController];
        resultTableViewController.lesson = self.lesson;
    }
}

#pragma mark - LessonDelegate
- (void)didReceiveLessonObject:(Lesson *)lesson {
    [JTProgressHUD hide];
    self.lesson = lesson;
    self.wordsArray = lesson.wordsArray;
    [self loadNextQuestionAndAnswers];
}

- (void)didReceiveUpdateLessonResponseWithBool:(BOOL)isSuccess {
    if (isSuccess) {
    }
}
@end
