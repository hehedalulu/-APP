//
//  SJCalendarView.h
//  拾间
//
//  Created by Wll on 17/1/26.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonthModel;
@interface SJCalendarView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>{
    UILabel *TempMonth;
}

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dayModelArray;
@property (strong, nonatomic) NSDate *tempDate;
@end

//CollectionViewHeader
@interface CalendarHeaderView : UICollectionReusableView
@end


//UICollectionViewCell
@interface CalendarCell : UICollectionViewCell
@property (weak, nonatomic) UILabel *dayLabel;

@property (strong, nonatomic) MonthModel *monthModel;
@end

//存储模型
@interface MonthModel : NSObject
@property (assign, nonatomic) NSInteger dayValue;
@property (strong, nonatomic) NSDate *dateValue;
@property (assign, nonatomic) BOOL isSelectedDay;
@end
