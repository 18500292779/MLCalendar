//
//  MLCalenderHeaderView.h
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLHeaderDelegate <NSObject>

//上个月
- (void)lastMonth;
//下个月
- (void)nextMonth;

- (void)todayMonth;

@end

@interface MLCalenderHeaderView : UIView

@property (nonatomic,strong)UILabel *titleLabel;


@property (nonatomic,strong)id<MLHeaderDelegate>delegate;


@end
