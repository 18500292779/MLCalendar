//
//  MLCalendarView.h
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCalendarItem.h"


@protocol MLCalendarDelegate <NSObject>

@optional

- (void)selectDate:(NSDate *)date;

@end

@interface MLCalendarView : UIView

@property (nonatomic,strong)NSArray *issueArray;


@property (nonatomic,strong)id<MLCalendarDelegate>delegate;


@end
