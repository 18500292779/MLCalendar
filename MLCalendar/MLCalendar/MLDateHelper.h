//
//  MLDateHelper.h
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLDateHelper : NSObject


+ (NSInteger)day:(NSDate *)date;

+ (NSInteger)month:(NSDate *)date;

+ (NSInteger)year:(NSDate *)date;

///在当前月份，上个月应该显示多少天
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

////当前月份一共有多少天
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;


+ (NSInteger)totaldaysInMonth:(NSDate *)date;

////上个月
+ (NSDate *)lastMonth:(NSDate *)date;
////下个月
+ (NSDate*)nextMonth:(NSDate *)date;

///判断是否为同一天
+(BOOL)adjustSameWithFirstDate:(NSDate *)fDate andSecondDate:(NSDate *)sDate;


@end
