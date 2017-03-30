//
//  MLCalendarCollectionViewCell.m
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import "MLCalendarCollectionViewCell.h"
#import "MLDateHelper.h"

@implementation MLCalendarCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        self.backgroundColor = [UIColor whiteColor];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 30, 15)];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        self.dateLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}



+ (instancetype)currentCellWithCollection:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath{
    MLCalendarCollectionViewCell *cell = (MLCalendarCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"calendar" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if(!cell){
        cell = [[MLCalendarCollectionViewCell alloc] init];
    }
    return cell;
}

- (void)configCellWithItems:(MLCalendarItem *)item{

    self.dateLabel.text = [NSString stringWithFormat:@"%ld",[MLDateHelper day:item.date]];
    if (item.type == current) {
        self.dateLabel.textColor = [UIColor blackColor];
    }else{
        self.dateLabel.textColor = [UIColor lightGrayColor];
    }
    NSDate *today = [NSDate date];
    if ([MLDateHelper adjustSameWithFirstDate:item.date andSecondDate:today]) {
        self.dateLabel.textColor = [UIColor redColor];;
    }
    if (item.select) {
        self.dateLabel.textColor = [UIColor blueColor];
    }
    
}


@end
