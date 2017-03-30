//
//  MLCalendarView.m
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import "MLCalendarView.h"
#import "MLCalendarCollectionViewCell.h"
#import "MLCalenderHeaderView.h"
#import "MLDateHelper.h"

@class MLCalendarView;

@interface MLCalendarView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MLHeaderDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger totalDays;
@property (strong, nonatomic)NSMutableArray *dataArr;// 数据源
@property (strong, nonatomic)UICollectionViewFlowLayout *layout;
@property (nonatomic,strong)MLCalenderHeaderView *headerView;
@property (nonatomic , strong) NSDate *date;

@property (nonatomic,strong)UISwipeGestureRecognizer *leftGestureRecognizer;
@property (nonatomic,strong)UISwipeGestureRecognizer *rightGestureRecognizer;

@end

@implementation MLCalendarView
{
    CGFloat myWidth;
    CGFloat myHeight;
    
    NSString *selectDate;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        selectDate = @"";
        myWidth = frame.size.width;
        myHeight = frame.size.height;
        _date = [NSDate date];
        [self aboutData];
        [self creatUI];
    }
    return self;
}

- (void)aboutData {
    
    self.date = [NSDate date];
    [self countTotalDays];
}

- (void)dealloc {
    [self removeGestureRecognizer:_leftGestureRecognizer];
    [self removeGestureRecognizer:_rightGestureRecognizer];
}


- (void)creatUI {
    
    _leftGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextMonth)];
    _rightGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(lastMonth)];
    _leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    _rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:_rightGestureRecognizer];
    [self addGestureRecognizer:_leftGestureRecognizer];
    
    _headerView = [[MLCalenderHeaderView alloc]initWithFrame:CGRectMake(0, 0, myWidth, 60)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.delegate = self;
    _headerView.titleLabel.text = [NSString stringWithFormat:@"%.2ld年%ld月",(long)[MLDateHelper year:_date],(long)[MLDateHelper month:_date]];
    [self addSubview:_headerView];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    CGFloat itemHeight = (myHeight-60)/(_totalDays/7);
    _layout.itemSize =  CGSizeMake(myWidth/7.0, itemHeight);
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, myWidth, myHeight-60) collectionViewLayout:_layout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.minimumZoomScale = 1;
    [self.collectionView registerClass:[MLCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"calendar"];
    [self addSubview:self.collectionView];
}


#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _totalDays;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MLCalendarCollectionViewCell *cell = [MLCalendarCollectionViewCell currentCellWithCollection:collectionView andIndexPath:indexPath];
    if (_dataArr.count!=0) {
        MLCalendarItem *item = _dataArr[indexPath.row];
        [cell configCellWithItems:item];
    }
    return cell;
};

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger daysInThisMonth = [MLDateHelper totaldaysInMonth:_date];
    NSInteger firstWeekday = [MLDateHelper firstWeekdayInThisMonth:_date];
    MLCalendarItem *item = [_dataArr objectAtIndex:indexPath.row];
    NSLog(@"选择的日期%@",item.date);
    selectDate = [NSString stringWithFormat:@"%@",item.date];
    if (indexPath.row<firstWeekday) {
        [self lastMonth];
    }else if (indexPath.row<daysInThisMonth+firstWeekday){
        for (int i=0; i<_dataArr.count; i++) {
            MLCalendarItem *model = _dataArr[i];
            model.select = NO;
            if (i==indexPath.row) {
                model.select = YES;
            }
             [_dataArr replaceObjectAtIndex:i withObject:model];
        }
        [self.collectionView reloadData];
    }else{
        [self nextMonth];
    }
    
    [self.delegate selectDate:item.date];
}


- (void)countTotalDays{
    
    self.dataArr = [NSMutableArray array];
    NSInteger daysInThisMonth = [MLDateHelper totaldaysInMonth:_date];
    NSInteger firstWeekday = [MLDateHelper firstWeekdayInThisMonth:_date];
    /// 总共需要显示的天数 为 上个月剩余天数+本月一共天数+下个月需要显示的天数
    NSInteger tempDays = firstWeekday + daysInThisMonth;
    _totalDays = tempDays%7==0?tempDays:tempDays+(7-tempDays%7);
    NSInteger day ;
    WhichMonth type ;
    for(int i=0;i<_totalDays;i++){
        
        NSDate *tempDate = self.date;
        if(i<firstWeekday){
            type = last;
            tempDate = [MLDateHelper lastMonth:_date];
            NSInteger lastTotalDays = [MLDateHelper totaldaysInMonth:tempDate];
            day = lastTotalDays-firstWeekday+i+1;
        }else if(i>(firstWeekday+daysInThisMonth-1)){
            type = next;
            tempDate = [MLDateHelper nextMonth:_date];
            day =i-firstWeekday-daysInThisMonth+1;
        }else{
            type = current;
            day = i-firstWeekday+1;
        }
        NSInteger month = [MLDateHelper month:tempDate];
        NSInteger year = [MLDateHelper year:tempDate];
        
        NSString *detailDate = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat:@"yy-MM-dd"];
        
        NSDate *date=[dateFormatter dateFromString:detailDate];
        MLCalendarItem *item = [[MLCalendarItem alloc] init];
        item.date = date;
        item.issues = [NSMutableArray array];
        item.type = type;
        if ([[NSString stringWithFormat:@"%@",item.date] isEqualToString:selectDate]) {
            item.select = YES;
        }else{
            item.select = NO;
        }
        [self.dataArr addObject:item];
    }
    CGFloat itemHeight = (myHeight-60)/(_totalDays/7);
    _layout.itemSize =  CGSizeMake(myWidth/7.0, itemHeight);
    
    _headerView.titleLabel.text = [NSString stringWithFormat:@"%.2ld年%ld月",(long)[MLDateHelper year:_date],(long)[MLDateHelper month:_date]];
    [self.collectionView reloadData];
}

- (void)nextMonth {
    [UIView transitionWithView:self.collectionView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^(void) {
        self.date = [MLDateHelper nextMonth:self.date];
        [self countTotalDays];
    } completion:nil];

}

- (void)lastMonth {
    [UIView transitionWithView:self.collectionView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^(void) {
        self.date = [MLDateHelper lastMonth:self.date];
        [self countTotalDays];
    } completion:nil];

}

- (void)todayMonth {
    self.date = [NSDate date];
    [self countTotalDays];
}


@end
