//
//  SJCalendarView.h
//  拾间
//
//  Created by Wll on 17/1/26.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCAlertView.h"

@class MonthModel;

@protocol SJCalendarViewDelegate <NSObject>
@optional
-(void)changeDateString:(NSString *)DateString;
@end
@interface SJCalendarView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>{
    UILabel *TempMonth;
    NSIndexPath *SelectedIndex;
    BOOL isSelectedItem;
    NSDateFormatter *dateFormatter;
}




@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dayModelArray;
@property (strong, nonatomic) NSDate *tempDate;
-(void)changeMonthLabel:(UISwipeGestureRecognizer *)gesture;
@property (nonatomic,weak) id<SJCalendarViewDelegate> CalendarViewDelegate;

@end

//CollectionViewHeader
@interface CalendarHeaderView : UICollectionReusableView
@end


//UICollectionViewCell
@interface CalendarCell : UICollectionViewCell{
    
}
-(void)test;
@property (weak, nonatomic) UILabel *dayLabel;
@property (nonatomic) UIImageView *dayLabelImg;
@property (strong, nonatomic) MonthModel *monthModel;
@property  BOOL SelectedDay;
@end

//存储模型
@interface MonthModel : NSObject
@property (assign, nonatomic) NSInteger dayValue;
@property (strong, nonatomic) NSDate *dateValue;
@property (assign, nonatomic) BOOL isSelectedDay;

@end
