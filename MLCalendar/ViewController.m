//
//  ViewController.m
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import "ViewController.h"
#import "MLCalendarView.h"
@interface ViewController ()<MLCalendarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MLCalendarView *calView = [[MLCalendarView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    calView.backgroundColor = [UIColor whiteColor];
    calView.delegate = self;
    [self.view addSubview:calView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)selectDate:(NSDate *)date {
    NSString *time = [[NSString stringWithFormat:@"%@",date] substringToIndex:10];
    [[MLAlertCenter defaultCenter] postAlertWithContent:[NSString stringWithFormat:@"您选择的日期是--%@",time]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
