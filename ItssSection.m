//
//  ItssSections.m
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/20.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import "ItssSection.h"
#import "ItssItem.h"
#import "ItssAnswer.h"

@implementation ItssSection
@synthesize name;
@synthesize items;

+ (NSMutableArray *)initData
{
    NSMutableArray *itss = [NSMutableArray array];
    
    ItssSection *section;
    ItssItem *item;
    NSMutableArray *answer;
    
    section = [[ItssSection alloc]init];
    section.name = @"達成度指標について";
    section.items = [NSMutableArray array];
    
    
    item = [[ItssItem alloc]init];
    item.title = @"規模（人）";
    item.contents = @"過去に該当するプロジェクトの遂行実績がある。";
    answer = [NSMutableArray array];
    [answer addObject:@"未選択"];
    [answer addObject:@"メンバー"];
    [answer addObject:@"上級メンバー"];
    [answer addObject:@"サブリーダー"];
    [answer addObject:@"リーダー"];
    [answer addObject:@"マネージャー"];
    item.answer = [[ItssAnswer alloc]init];
    item.answer.label = answer;
    [section.items addObject:item];
    
    
    item = [[ItssItem alloc]init];
    item.title = @"規模（売上）";
    item.contents = @"過去に該当するプロジェクトの遂行実績がある。";
    answer = [NSMutableArray array];
    [answer addObject:@"未選択"];
    [answer addObject:@"メンバー"];
    [answer addObject:@"上級メンバー"];
    [answer addObject:@"サブリーダー"];
    [answer addObject:@"リーダー"];
    [answer addObject:@"マネージャー"];
    item.answer = [[ItssAnswer alloc]init];
    item.answer.label = answer;
    [section.items addObject:item];
    
    [itss addObject:section];
    
    return itss;
}

@end
