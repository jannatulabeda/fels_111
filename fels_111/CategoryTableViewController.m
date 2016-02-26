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

@interface CategoryTableViewController () <UITableViewDataSource, UITableViewDelegate, CategoryDelegate> {
    
    int pageNumber; // Page number to send API request
    int perPageData; // Number of data to load per page
}

@property (strong, nonatomic) NSMutableArray *categoryArray;

@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.categoryArray = [[NSMutableArray alloc] init];
    
    // Initially page number is set to 1
    pageNumber = 1;
    
    // Number of data per page is set to 3 for testing purpose
    perPageData = 3;
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Clear category array
    [self.categoryArray removeAllObjects];
    
    // Get Category list
    [JTProgressHUD show];
    CategoryManager *categoryManager = [[CategoryManager alloc] init];
    categoryManager.delegate = self;
    
    // Send auth token from stored one [Implement later]
    [categoryManager doGetCategoriesWithAuthToken:@"" pageNumber:pageNumber perPageData:perPageData];
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
        cell.contentLabel.text = @""; // No API data found [Need to ask]
        
        // Set image
        [cell.categoryImageView sd_setImageWithURL:[NSURL URLWithString:category.imageURL]
                                  placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // If navigating to LessonViewController
    if ([[segue identifier] isEqualToString:@"toLessonSegue"]) {
        // Will be implemented later
        /*
         NSIndexPath *path = [self.tableView indexPathForSelectedRow];
         LessonViewController *lessonViewController = [segue destinationViewController];
         LessonCategory *category = [self.categoryArray objectAtIndex:path.row];
         lessonViewController.category = category;
         */
    }
}

#pragma mark - CategoryManager Delegate

// Receive category data from API response
- (void)didReceiveCategoryDataWithArray:(NSArray *)categoryArray {
    
    [self.categoryArray addObjectsFromArray:categoryArray];
    [self.tableView reloadData];
    [JTProgressHUD hide];
}

@end
