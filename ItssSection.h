//
//  ItssSections.h
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/20.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItssSection: NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
+ (NSMutableArray *)initData;
@end
