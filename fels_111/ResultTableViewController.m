//
//  ResultTableViewController.m
//  fels_111
//
//  Created by Jannatul on 2/23/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "ResultTableViewController.h"
#import "ResultTableViewCell.h"
#import "Word.h"
#import "Answer.h"
#import "Utils.h"

@interface ResultTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lessonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *learnedWordsLabel;
@property (strong, nonatomic) NSMutableArray *resultArray;
@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultArray = [self getResultArray];
    self.lessonNameLabel.text = self.lesson.lessonName;
    if (self.resultArray.count > 0) {
        self.learnedWordsLabel.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)[self.resultArray count], (unsigned long)[self.lesson.wordsArray count]];
    } else {
        self.learnedWordsLabel.text = @"No result found!! :(";
    }
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = (ResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    Word *word = [self.resultArray objectAtIndex:indexPath.row];
    // Set Image
    cell.resultImageView.image = word.isCorrectlyAnswered ? [UIImage imageNamed:RIGHT_SIGN_IMAGE] : [UIImage imageNamed:CROSS_SIGN_IMAGE];
    cell.contentLabel.text = word.wordContent;
    cell.resultLabel.text = word.answered.answerContent;
    return cell;
}

#pragma mark - Other methods
- (NSMutableArray *)getResultArray {
    NSMutableArray *learnedWordArray = [[NSMutableArray alloc]init];
    for (Word *word in [self.lesson wordsArray]) {
        if(word.answered) {
            [learnedWordArray addObject:word];
        }
    }
    return learnedWordArray;
}
@end
