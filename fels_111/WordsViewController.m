//
//  WordsViewController.m
//  fels_111
//
//  Created by Jannatul on 3/2/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "WordsViewController.h"
#import "Constants.h"
#import "DropDownListView.h"
#import "WordTableViewCell.h"
#import "CategoryManager.h"
#import "User.h"
#import "Utils.h"
#import "LessonCategory.h"
#import "WordListManager.h"
#import "Word.h"
#import "JTProgressHUD.h"

@interface WordsViewController () <kDropDownListViewDelegate, UITableViewDataSource, UITableViewDelegate, CategoryDelegate, WordListDelegate> {
    NSArray *learnedButtonTextArray;
    NSMutableDictionary *categoryButtonTextDict;
    BOOL isDropDownVisible;
    NSMutableArray *allCategoryArray;
    int categoryPageCount;
    int categoryTotalPages;
}
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *learnedButton;
@property (weak, nonatomic) IBOutlet UITableView *wordListTableView;
@property (strong, nonatomic) NSMutableArray *wordListArray;

@end

@implementation WordsViewController
NSString *const _ALL = @"All";
NSString *const _LEARNED= @"Learned";
NSString *const _NOT_LEARNED = @"Not learned";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wordListArray = [[NSMutableArray alloc]init];
    allCategoryArray = [[NSMutableArray alloc]init];
    categoryButtonTextDict = [[NSMutableDictionary alloc]init];
    [self setupButtons];
    // Do any additional setup after loading the view.
    [JTProgressHUD show];
    [self doGetCategory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupButtons {
    // Set border of buttons
    [[self.learnedButton layer] setBorderWidth:1.5];
    [[self.learnedButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[self.categoryButton layer] setBorderWidth:1.5];
    [[self.categoryButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    // Learned button array
    learnedButtonTextArray = @[_ALL, _LEARNED, _NOT_LEARNED];
}

- (void)doGetCategory {
    categoryPageCount++;
    // Fetch all category list
    CategoryManager *categoryManager = [[CategoryManager alloc] init];
    categoryManager.delegate = self;
    User *user = [Utils getUserFromKeychain];
    [categoryManager doGetCategoriesWithAuthToken:user.authToken
                                       pageNumber:categoryPageCount
                                      perPageData:PER_PAGE_DATA];
}

#pragma mark - Delegate method
- (void)didReceiveCategoryDataWithArray:(NSArray *)categoryArray {
    [JTProgressHUD hide];
    [allCategoryArray addObjectsFromArray:categoryArray];
    // Get the total pages
    if (allCategoryArray && allCategoryArray.count) {
        LessonCategory *lessonCategory = [allCategoryArray objectAtIndex:0];
        categoryTotalPages = lessonCategory.totalPages;
    }
    if(categoryPageCount < categoryTotalPages) {
        [self doGetCategory];
    }
    // If all data are received
    if (categoryPageCount == categoryTotalPages) {
        for (LessonCategory *category in allCategoryArray) {
            NSString *key = [NSString stringWithFormat:@"%d",category.categoryId];
            [categoryButtonTextDict setObject:category.categoryName forKey:key];
        }
        if (allCategoryArray.count) {
            LessonCategory *category = [allCategoryArray objectAtIndex:0];
            [self.categoryButton setTitle:category.categoryName forState:UIControlStateNormal];
            
            // Get the category id and option
            [self.wordListArray removeAllObjects];
            NSArray *allKeys =[categoryButtonTextDict allKeysForObject:category.categoryName];
            NSString *categoryId = [allKeys lastObject];
            [self getWordListWithCategoryId:categoryId
                                     option:[self getKeyOfLearnedDictionaryForKey:self.learnedButton.titleLabel.text]];
        }
    }
}

- (void)didReceiveWordListWithArray:(NSArray *)wordsArray {
    [JTProgressHUD hide];
    if (wordsArray) {
        [self.wordListArray addObjectsFromArray:wordsArray];
    }
    [self.wordListTableView reloadData];
}

- (void)getWordListWithCategoryId:(NSString *)categoryId
                           option:(NSString *)option {
    [JTProgressHUD show];
    // Get word list
    WordListManager *wordListManager = [[WordListManager alloc]init];
    wordListManager.delegate = self;
    User *user = [Utils getUserFromKeychain];
    [wordListManager doGetWordListWithCategoryId:[categoryId intValue]
                                          option:option
                                            page:1
                                     perPageData:PER_PAGE_DATA
                                       authToken:user.authToken];
}

- (NSString *)getKeyOfLearnedDictionaryForKey:(NSString *)key {
    if([key isEqualToString:_ALL]) {
        return KEY_ALL_WORD;
    } else if([key isEqualToString:_LEARNED]) {
        return KEY_LEARNED;
    } else if([key isEqualToString:_NOT_LEARNED]) {
        return KEY_NO_LEARN;
    }
    return KEY_ALL_WORD;
}

#pragma mark - Button Action
- (IBAction)categoryButtonPressed:(id)sender {
    if (!isDropDownVisible) {
        [self showPopUpWithTitle:@"Select category"
                      withOption:[categoryButtonTextDict allValues]
                              xy:CGPointMake(self.categoryButton.frame.origin.x + 20, self.categoryButton.frame.origin.y + self.categoryButton.frame.size.height)
                            size:CGSizeMake(self.categoryButton.frame.size.width - 20, 200)
                      isMultiple:NO
                             tag:self.categoryButton.tag];
    }
}

- (IBAction)learnedButtonPressed:(id)sender {
    if (!isDropDownVisible) {
        [self showPopUpWithTitle:@"Select option"
                      withOption:learnedButtonTextArray
                              xy:CGPointMake(self.learnedButton.frame.origin.x, self.learnedButton.frame.origin.y + self.learnedButton.frame.size.height)
                            size:CGSizeMake(self.learnedButton.frame.size.width - 20, 200)
                      isMultiple:NO
                             tag:self.learnedButton.tag];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.wordListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *wordCellIdentifier = @"wordCell";
    WordTableViewCell *cell = (WordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:wordCellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    if (indexPath.row < [self.wordListArray count]) {
        Word *word = [self.wordListArray objectAtIndex:indexPath.row];
        cell.wordContentLabel.text = word.wordContent;
        NSArray *answerArray = word.answersArray;
        for (Answer *answer in answerArray) {
            if (answer.isCorrect) {
                cell.answerContentLabel.text = answer.answerContent;
                break;
            }
        }
    }
    return cell;
}

#pragma mark - KDropdownList
- (void)showPopUpWithTitle:(NSString*)popupTitle
               withOption:(NSArray*)arrOptions
                       xy:(CGPoint)point
                     size:(CGSize)size
               isMultiple:(BOOL)isMultiple
                      tag:(int)tag{
    DropDownListView *dropDownList = [[DropDownListView alloc]initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    dropDownList.tag = tag;
    dropDownList.delegate = self;
    [dropDownList showInView:self.view animated:YES];
    // Set DropDown backGroundColor
    [dropDownList SetBackGroundDropDown_R:220.0 G:220.0 B:220.0 alpha:1.0];
    isDropDownVisible = YES;
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    NSString *categoryId = self.categoryButton.titleLabel.text;
    NSString *learned = self.learnedButton.titleLabel.text;
    // Get Selected Value
    if(dropdownListView.tag == self.learnedButton.tag) {
        learned = [learnedButtonTextArray objectAtIndex:anIndex];
        [self.learnedButton setTitle:learned forState:UIControlStateNormal];
    } else {
        categoryId = [[categoryButtonTextDict allValues] objectAtIndex:anIndex];
        [self.categoryButton setTitle:categoryId forState:UIControlStateNormal];
        
    }
    isDropDownVisible = NO;
    // Get the category id
    [self.wordListArray removeAllObjects];
    NSArray *allKeysCategoryDict =[categoryButtonTextDict allKeysForObject:categoryId];
    categoryId = [allKeysCategoryDict lastObject];
    [self getWordListWithCategoryId:categoryId
                             option:[self getKeyOfLearnedDictionaryForKey:learned]];
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)ArryData {
}

- (void)DropDownListViewDidCancel{
}

@end
