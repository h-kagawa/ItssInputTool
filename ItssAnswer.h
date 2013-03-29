//
//  ItssAnswer.h
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/23.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItssAnswer : NSObject
@property (nonatomic, strong) NSMutableArray *label;
@property (nonatomic, strong) NSNumber *index;
- (NSString *)answerText;
@end


