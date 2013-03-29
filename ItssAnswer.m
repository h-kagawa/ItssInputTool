//
//  ItssAnswer.m
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/23.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import "ItssAnswer.h"

@implementation ItssAnswer
@synthesize label;
@synthesize index;

- (NSString *)answerText {
    return [label objectAtIndex:[index integerValue]];    
}

@end
