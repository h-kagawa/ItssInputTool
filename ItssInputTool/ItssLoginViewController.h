//
//  ItssLoginViewController.h
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/03/04.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItssLoginViewController;

@protocol ItssLoginViewControllerDeletega
- (void)itssLoginViewControllerDidLogin:
(ItssLoginViewController *)controller;
@end

@interface ItssLoginViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *textUserID;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UILabel *resultMessage;
@property (nonatomic, weak) id  delegate;
-(IBAction)Login:(id)sender;
-(IBAction)textFieldUserIDNext:(id)sender;
-(IBAction)textFieldPasswordDone:(id)sender;

// CAS関係
@property (nonatomic) BOOL isAuthenticated;
- (IBAction) authenticate;
- (IBAction) sendRequest;
- (IBAction) logout;
- (void) authenticationSucceeded;
- (void) authenticationFailed:(NSString *)reason;
@end
