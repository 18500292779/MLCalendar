//
//  MLCalendarItem.h
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    last = 0,
    current = 1,
    next = 2,
}WhichMonth;


@interface MLCalendarItem : NSObject

@property (nonatomic,copy) NSDate *date;// 日期

@property (nonatomic,strong) NSMutableArray *issues;// 事件

@property (nonatomic,assign)WhichMonth type;

@property (nonatomic,assign)BOOL select;

@end
