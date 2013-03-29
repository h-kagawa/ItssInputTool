//
//  ItssTableViewController.m
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/19.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import "ItssItemTableViewController.h"
#import "ItssDetailTableViewController.h"
#import "ItssSection.h"
#import "ItssItem.h"
#import "ItssAnswer.h"

@interface ItssItemTableViewController ()

@end

@implementation ItssItemTableViewController
@synthesize sectionData;
ItssAnswer *itssAnswer;

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
    /*
    ItssSection *sec = ([sections objectAtIndex:section] items count];
    return [sec.items count];
    */
    return [sectionData.items count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionData.name;
    /*
    if (section == 0) {
        return @"達成度指標について";
        
        //return zeroSizeView_;  // zeroSizeView_ = [[UIView alloc] initWithFrame:CGRectZero];
    } else {
        return nil;
    }
    */
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ItssItem *item = [sectionData.items objectAtIndex:indexPath.row];
	cell.textLabel.text = item.title;
	cell.detailTextLabel.text = ([item.answer.index integerValue] == 0 ) ? @"未設定" : @"済み";
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
    ItssDetailTableViewController *itssDetailTableViewController =
        [[self.navigationController viewControllers] objectAtIndex:2];
    
    ItssItem *itssItem = [sectionData.items objectAtIndex:indexPath.row];
    itssDetailTableViewController.answerData = itssItem.answer;
    itssDetailTableViewController.titleLabel.textLabel.text = itssItem.title;
    itssDetailTableViewController.contents.textLabel.text = itssItem.contents;
    itssDetailTableViewController.answerLabel.textLabel.text
        //= [itssItem.answer.label objectAtIndex:[itssItem.answer.index integerValue]];
    = [itssItem.answer answerText];

}

// 画面遷移などで self.tableView が表示される時に呼ばれる
- (void)viewDidAppear:(BOOL)animated
{
    // 強制的にメニューの項目をすべて再表示させる。
    // これをしないと、子メニューで選択された項目の内容が表示に反映されない。
    [self.tableView reloadData];
    
    [super viewDidAppear:animated];
}

@end
