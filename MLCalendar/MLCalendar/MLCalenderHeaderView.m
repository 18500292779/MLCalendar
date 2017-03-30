//
//  MLCalenderHeaderView.m
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import "MLCalenderHeaderView.h"

@implementation MLCalenderHeaderView
{
    CGFloat width;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        width = frame.size.width;
        [self creatUI];
    }
    return self;
}


- (void)creatUI {
    UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastButton setTitle:@"上个月" forState:UIControlStateNormal];
    [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lastButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [lastButton addTarget:self action:@selector(lastClick) forControlEvents:UIControlEventTouchUpInside];
    lastButton.frame = CGRectMake(0, 0, 50, 30);
    [self addSubview:lastButton];
    
    UIButton *todayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [todayButton setTitle:@"今天" forState:UIControlStateNormal];
    todayButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [todayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [todayButton addTarget:self action:@selector(todayClick) forControlEvents:UIControlEventTouchUpInside];
    todayButton.frame = CGRectMake(width - 100, 0, 50, 30);
    [self addSubview:todayButton];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"下个月" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    nextButton.frame = CGRectMake(width - 50, 0, 50, 30);
    [self addSubview:nextButton];

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, width - 100, 30)];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    
    NSArray *arr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    CGFloat weekWidth = width/7.0;
    for (int i= 0; i<arr.count; i++) {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(weekWidth * i, 30, weekWidth, 30)];
        weekLabel.textColor = [UIColor redColor];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.text = [arr objectAtIndex:i];
        weekLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:weekLabel];
    }
}
- (void)todayClick {
    [self.delegate todayMonth];
}

- (void)lastClick {
    [self.delegate lastMonth];
}

- (void)nextClick {
    [self.delegate nextMonth];
}

@end
