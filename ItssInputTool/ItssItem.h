//
//  ItssItems.h
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/02/20.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItssAnswer.h"

@interface ItssItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, strong) ItssAnswer *answer;
@end
