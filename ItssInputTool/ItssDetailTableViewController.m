//
//  ItssDetailTableViewController.m
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/22.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import "ItssDetailTableViewController.h"
#import "ItssAnswer.h"

@interface ItssDetailTableViewController ()

@end


@implementation ItssDetailTableViewController
@synthesize answerData;
@synthesize titleLabel;
@synthesize contents;
@synthesize answerLabel;
@synthesize contentsLabel;
CGFloat w;
CGFloat h;

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
    picker.delegate=self;    //デリゲートを自分自身に設定

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
    if(indexPath.section == 2) {
        [self push];
    } else {
        [self pull];
    }
}

//列数の設定（設定する列の数をreturnで返す）
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


//！！行も列も番号は0から始まるので注意
//列（componentの値で渡される）に対する、行数の設定（設定する行の数をreturnで返す）
- (NSInteger) pickerView: (UIPickerView*)pView
 numberOfRowsInComponent:(NSInteger) component {
    if (component==0) {
        return answerData.label.count;
    }
    else{
        return 0; //帰り値が存在するので、関係ない場合でもとりあえず0を返させる
    }
}


//列（componentの値）、行（rowの値）に対する表示するものを設定
- (NSString*)pickerView: (UIPickerView*)pView
            titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d %@", row+1, [answerData.label objectAtIndex:row ]];
}

- (IBAction)push{
    
    //スクリーンサイズ取得
    CGRect r = [[UIScreen mainScreen] bounds];
    //CGFloat w = r.size.width;
    CGFloat h = r.size.height + 44;
    
    picker = [[UIPickerView alloc] init]; //初期化+領域確保 size=320*250
    picker.delegate = self; //自分自身をデリゲートに設定する。
    picker.dataSource = self; //自分自身をデータソースに設定する。
    picker.showsSelectionIndicator = YES; //現在選択している値にラインをあてるかどうか。
    [picker selectRow:[answerData.index integerValue] inComponent:0 animated:NO]; //今回は初期値を45番目とする
    
    CGRect pr = [picker bounds];
    //CGFloat pw = pr.size.width;
    CGFloat ph = pr.size.height;
    
    //アニメーションの設定開始
    CGContextRef context = UIGraphicsGetCurrentContext();
    [picker setCenter:CGPointMake(160, h + ph)];    // 表示する中心座標を表示画面外に設定
    //Pickerの大きさが320*250なので+125にすると丁度隠れる。
    
    [self.view addSubview:picker]; //Pickerを外部で表示させておきます。
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //アニメーションの種類を設定
    [UIView setAnimationDuration:0.3];    // 時間の指定
    [picker setCenter:CGPointMake(160, h - ph)];    // 表示する中心座標を表示画面中央に
    
    [UIView commitAnimations]; //アニメーションを開始
}

- (IBAction)pull{
    //スクリーンサイズ取得
    CGRect r = [[UIScreen mainScreen] bounds];
    //CGFloat w = r.size.width;
    CGFloat h = r.size.height + 44;
    
    //picker = [[UIPickerView alloc] init]; //初期化+領域確保 size=320*250
    //picker.delegate = self; //自分自身をデリゲートに設定する。
    //picker.dataSource = self; //自分自身をデータソースに設定する。
    //picker.showsSelectionIndicator = YES; //現在選択している値にラインをあてるかどうか。
    //[picker selectRow:0 inComponent:0 animated:NO]; //今回は初期値を45番目とする
    
    CGRect pr = [picker bounds];
    //CGFloat pw = pr.size.width;
    CGFloat ph = pr.size.height;
    
    //アニメーションの設定開始
    CGContextRef context = UIGraphicsGetCurrentContext();
    [picker setCenter:CGPointMake(160, h - ph)];    // 表示する中心座標を表示画面中央に
    //Pickerの大きさが320*250なので+125にすると丁度隠れる。
    
    [self.view addSubview:picker]; //Pickerを外部で表示させておきます。
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //アニメーションの種類を設定
    [UIView setAnimationDuration:0.3];    // 時間の指定
    [picker setCenter:CGPointMake(160, h + ph)];    // 表示する中心座標を表示画面外に設定
    
    [UIView commitAnimations]; //アニメーションを開始
    
}

/**
 PickerViewが選択された時に呼び出されるデレゲート
 **/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    answerData.index = [[NSNumber alloc] initWithInteger:row];
    answerLabel.textLabel.text = [answerData.label objectAtIndex:row];
    [self pull];
}

-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    //w = self.view.bounds.size.width;
    //h = self.view.bounds.size.height;
}




@end
