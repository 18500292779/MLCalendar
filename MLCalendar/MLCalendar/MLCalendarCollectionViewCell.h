//
//  MLCalendarCollectionViewCell.h
//  MLCalendar
//
//  Created by zhaoml on 2017/3/30.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCalendarItem.h"

@interface MLCalendarCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong) UILabel *dateLabel;


- (void)configCellWithItems:(MLCalendarItem *)item;

+ (instancetype)currentCellWithCollection:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) MLCalendarItem *cellItem;
@end
