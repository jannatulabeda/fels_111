//
//  CategoryTableViewController.m
//  fels_111
//
//  Created by Jannatul on 2/23/16.
//  Copyright © 2016 Md Mainul Haque. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryTableViewCell.h"
#import "LessonViewController.h"
#import "CategoryManager.h"
#import "LessonCategory.h"
#import "JTProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "User.h"
#import "Utils.h"
#import "UITableView+DragLoad.h"

@interface CategoryTableViewController () <UITableViewDataSource, UITableViewDelegate, CategoryDelegate, UITableViewDragLoadDelegate> {
    int pageNumber; // Page number to send API request
    int perPageData; // Number of data to load per page
    int totalPages; // Total page number
}

@property (strong, nonatomic) NSMutableArray *categoryArray;
@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryArray = [[NSMutableArray alloc] init];
    // Initially page number is set to 1
    pageNumber = 1;
    [self.tableView setDragDelegate:self refreshDatePermanentKey:@"CategoryList"];
}

- (void)viewWillAppear:(BOOL)animated {
    // Clear category array
    [self.categoryArray removeAllObjects];
    
    // Get Category list
    [JTProgressHUD show];
    CategoryManager *categoryManager = [[CategoryManager alloc] init];
    categoryManager.delegate = self;
    
    // Send request for category list
    User *user = [Utils getUserFromKeychain];
    [categoryManager doGetCategoriesWithAuthToken:user.authToken pageNumber:pageNumber perPageData:PER_PAGE_DATA];
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
    return [self.categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *categoryCellIdentifier = @"categoryCell";
    CategoryTableViewCell *cell =(CategoryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:categoryCellIdentifier forIndexPath:indexPath];
    
    // Set category imageView border
    [cell.categoryImageView setBackgroundColor:[UIColor clearColor]];
    [[cell.categoryImageView layer] setBorderWidth:0.5];
    [[cell.categoryImageView layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    
    // Configure the cell...
    if (indexPath.row <= [self.categoryArray count]) {
        // Get category object
        LessonCategory *category = [self.categoryArray objectAtIndex:indexPath.row];
        
        // Set category name
        cell.categoryNameLabel.text = category.categoryName;
        // Set learned words
        if (category.learnedWords > 1) {
            cell.learnedWordsLabel.text = [NSString stringWithFormat:@"You have learned %i words", category.learnedWords];
        } else {
            cell.learnedWordsLabel.text = [NSString stringWithFormat:@"You have learned %i word", category.learnedWords];
        }
        // [Need to ask] about it
        cell.contentLabel.text = @""; // No API data found
        // Set image
        [cell.categoryImageView sd_setImageWithURL:[NSURL URLWithString:category.imageURL]
                                  placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    return cell;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // If navigating to LessonViewController
    if ([[segue identifier] isEqualToString:@"toLessonSegue"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        LessonViewController *lessonViewController = [segue destinationViewController];
        LessonCategory *category = [self.categoryArray objectAtIndex:path.row];
        lessonViewController.category = category;
    }
}

#pragma mark - CategoryManager Delegate
// Receive category data from API response
- (void)didReceiveCategoryDataWithArray:(NSArray *)categoryArray {
    if (categoryArray && categoryArray.count > 0) {
        [self.categoryArray addObjectsFromArray:categoryArray];
        [self.tableView reloadData];
    }
    [JTProgressHUD hide];
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

#pragma mark - Control datasource
- (void)finishLoadMore {
    if (pageNumber == totalPages) {
        [self.tableView finishLoadMore];
        return;
    }
    // Get Category list
    [JTProgressHUD show];
    CategoryManager *categoryManager = [[CategoryManager alloc] init];
    categoryManager.delegate = self;
    // Send request for category list
    User *user = [Utils getUserFromKeychain];
    [categoryManager doGetCategoriesWithAuthToken:user.authToken pageNumber:++pageNumber perPageData:PER_PAGE_DATA];
    [self.tableView finishLoadMore];
}

#pragma mark - Drag delegate methods
- (void)dragTableDidTriggerLoadMore:(UITableView *)tableView {
    // Send load more request
    [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:2];
}

- (void)dragTableLoadMoreCanceled:(UITableView *)tableView {
    // Cancel load more request
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishLoadMore) object:nil];
}
@end
