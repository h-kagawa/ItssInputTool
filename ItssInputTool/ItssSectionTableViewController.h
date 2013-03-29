//
//  ItssSectionViewController.h
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/21.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItssSectionTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *itssSections;

// CAS関係
@property (nonatomic) BOOL isAuthenticated;
- (IBAction) authenticate;
- (IBAction) sendRequest;
- (IBAction) logout;
- (void) authenticationSucceeded;
- (void) authenticationFailed:(NSString *)reason;
@end
