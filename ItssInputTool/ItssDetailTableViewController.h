//
//  ItssDetailTableViewController.h
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/22.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItssAnswer.h"

@interface ItssDetailTableViewController : UITableViewController
<UIPickerViewDelegate>{ //プロトコルの実装
    //アウトレット
    IBOutlet UIPickerView *picker;    //ピッカービュー
}
@property (weak, nonatomic) IBOutlet UITableViewCell *titleLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *contents;
@property (weak, nonatomic) IBOutlet UITableViewCell *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;

@property (nonatomic, strong) ItssAnswer *answerData;

//ボタンを押した時に行うメソッド
- (IBAction)push;
- (IBAction)pull;

@end
