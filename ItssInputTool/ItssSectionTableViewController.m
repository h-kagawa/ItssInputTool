//
//  ItssSectionViewController.m
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/21.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import "ItssSectionTableViewController.h"
#import "ItssItemTableViewController.h"
#import "ItssLoginViewController.h"
#import "ItssSection.h"

@interface ItssSectionTableViewController ()

@end

@implementation ItssSectionTableViewController
@synthesize itssSections;
@synthesize isAuthenticated;
ItssSection *itssSection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [itssSections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ItssSection *section = [itssSections objectAtIndex:indexPath.section];
	cell.textLabel.text = section.name;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%d %@", section.items.count, @"問"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ItssItemTableViewController *itssItemTableViewController =
        [[self.navigationController viewControllers] objectAtIndex:1];
    //ItssItemTableViewController *itssItemTableViewController =
    //    [[self.navigationController viewControllers] getObjects:@"ItssItem"];
    
    itssSection = [itssSections objectAtIndex:indexPath.row];
    
    itssItemTableViewController.sectionData = itssSection;

}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showPertnersList"]) {
        ItssItemTableViewController *itssItemTableViewController = [segue destinationViewController];
        itssItemTableViewController.sectionData = sectionData;
    }
    
}
 */

/**
 メイン画面の前にログイン画面を出す設定
 **/
- (void)viewWillAppear:(BOOL)animated {
    if (![self hasLoginSettings]) {
        [self showLoginView];
    }
    
}

/*
 * ログイン設定があるかを判定する。
 */
- (BOOL)hasLoginSettings {
    return isAuthenticated;
}

/*
 * ログイン画面を表示する。
 */
- (void)showLoginView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ItssLoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

// ログインメソッド
- (void)itssLoginViewControllerDidLogin:
(ItssLoginViewController *)controller
{
    isAuthenticated = controller.isAuthenticated;
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
