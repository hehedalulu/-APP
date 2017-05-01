//
//  SJCalendarView.m
//  拾间
//
//  Created by Wll on 17/1/26.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "SJCalendarView.h"
#import "NSDate+Formatter.h"
#import "SJClockView.h"

#define HeaderViewHeight 30
//#define WeekViewHeight 40

@implementation SJCalendarView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    isSelectedItem = YES;
    UIImageView *SJWeekViewBg = [[UIImageView alloc]init];
    SJWeekViewBg.frame = CGRectMake(0, 0,
                                    [UIScreen mainScreen].bounds.size.width,
                                    [UIScreen mainScreen].bounds.size.height);
    SJWeekViewBg.image = [UIImage imageNamed:@"weekView_bg.png"];
    [self addSubview:SJWeekViewBg];
    
    //时钟
    SJClockView *clock = [[SJClockView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.634,
                                                                      [UIScreen mainScreen].bounds.size.width*1.53,
                                                                      [UIScreen mainScreen].bounds.size.width*0.173,
                                                                      [UIScreen mainScreen].bounds.size.width*0.173)];
    [clock drawRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.634,
                               [UIScreen mainScreen].bounds.size.width*1.53,
                               [UIScreen mainScreen].bounds.size.width*0.173,
                               [UIScreen mainScreen].bounds.size.width*0.173)];
    [self addSubview:clock];
    
    

    
    UIImageView *WeekHeaderImage = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.161,
                                                                               [UIScreen mainScreen].bounds.size.width*0.329,
                                                                               [UIScreen mainScreen].bounds.size.width*0.56,
                                                                               [UIScreen mainScreen].bounds.size.width*0.070)];
    WeekHeaderImage.image = [UIImage imageNamed:@"week_label.png"];
    [self addSubview:WeekHeaderImage];
    
    UIImageView *TempWeekImage = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.161,
                                                                              [UIScreen mainScreen].bounds.size.width*0.389,
                                                                              [UIScreen mainScreen].bounds.size.width*0.56,
                                                                              [UIScreen mainScreen].bounds.size.width*0.7266)];
    TempWeekImage.image = [UIImage imageNamed:@"WeekLabelbg.png"];
    [self addSubview:TempWeekImage];
    TempWeekImage.userInteractionEnabled = YES;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [TempWeekImage addSubview:self.collectionView];
    self.collectionView.userInteractionEnabled = YES;

    
    TempMonth = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.217,
                                                         [UIScreen mainScreen].bounds.size.width*0.093,
                                                         [UIScreen mainScreen].bounds.size.width*0.46,
                                                         [UIScreen mainScreen].bounds.size.width*0.088)];

    self.tempDate = [NSDate date];
    [self getDataDayModel:self.tempDate];
    TempMonth.textColor = [UIColor whiteColor];
    TempMonth.textAlignment = NSTextAlignmentCenter;
    TempMonth.font = [UIFont fontWithName:@"BatikRegular" size:21];
    TempMonth.text = self.tempDate.weekdayByLineWithDate;
    [self addSubview:TempMonth];
//    [self addChangeMonthGesture];
    

}
- (BOOL)isFontDownloaded:(NSString *)fontName
{
    
    UIFont* aFont = [UIFont fontWithName:fontName size:12.0];
    BOOL isDownloaded = (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame));
    return isDownloaded;
}




//判断上下滑动Z
-(void)changeMonthLabel:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"日历view中上滑手势");
        self.tempDate = [self getNextMonth:self.tempDate];
        TempMonth.text = self.tempDate.weekdayByLineWithDate;
        [self getDataDayModel:self.tempDate];
    }
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"日历view中下滑手势");            

        self.tempDate = [self getLastMonth:self.tempDate];
        TempMonth.text = self.tempDate.weekdayByLineWithDate;
        [self getDataDayModel:self.tempDate];
    }
}


- (void)getDataDayModel:(NSDate *)date{
    NSUInteger days = [self numberOfDaysInMonth:date];
    NSInteger week = [self startDayOfWeek:date];
    self.dayModelArray = [[NSMutableArray alloc] initWithCapacity:42];
    int day = 1;
    for (int i= 1; i<days+week; i++) {
        if (i<week) {
            [self.dayModelArray addObject:@""];
        }else{
            MonthModel *mon = [MonthModel new];
            mon.dayValue = day;
            NSDate *dayDate = [self dateOfDay:day];
            mon.dateValue = dayDate;
            if ([dayDate.yyyyMMddByLineWithDate isEqualToString:[NSDate date].yyyyMMddByLineWithDate]) {
                mon.isSelectedDay = YES;
            }
            [self.dayModelArray addObject:mon];
            day++;
        }
    }
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dayModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    cell.dayLabel.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.item == SelectedIndex.item && SelectedIndex != nil) {
        //如果是展开
        if (isSelectedItem == YES) {
            //            cell.dayLabelImg.hidden = NO;
            cell.SelectedDay = YES;
            [cell test];
            NSLog(@"new cell");
        }else{
            //            cell.dayLabelImg.hidden = YES;
            cell.SelectedDay = NO;
            [cell test];
        }
        //不是自身
    } else {
        cell.SelectedDay = NO;
    }
    
    id mon = self.dayModelArray[indexPath.row];
    if ([mon isKindOfClass:[MonthModel class]]) {
        cell.monthModel = (MonthModel *)mon;
        
    }else{
        cell.dayLabel.text = @"";
        cell.dayLabelImg.hidden = YES;
        
    }
//    cell.dayLabelImg.hidden = NO;

    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    CalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CalendarHeaderView" forIndexPath:indexPath];
//    return headerView;
//}

-(int)LaterThanToday:(NSDate *)now withOtherDate:(NSDate*)date{
    // 0可以点击  1过去 2未来
    NSDate *date309 = [dateFormatter dateFromString:@"2017-03-09"];
    NSComparisonResult oldResult = [date compare:date309];
    if (oldResult==NSOrderedDescending) {
        NSComparisonResult result = [date compare:now];
        if (result==NSOrderedAscending) {
            NSLog(@"正好");
            return 0;
        }else{
            NSLog(@"未来");
            return 2;
        }
    }else{
        NSLog(@"过去");
        return 1;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id mon = self.dayModelArray[indexPath.row];
    NSLog(@"点击的是%ld",(long)(indexPath.row+1)%7);
    NSLog(@"点击的行数是%d",(int)(indexPath.row+1)/7);
    
    NSDate *now = [NSDate date];
    //如果是过去 可以点击
    int value = [self LaterThanToday:now withOtherDate:[mon dateValue]];
    if (value==0) {
        if ([mon isKindOfClass:[MonthModel class]]) {
            NSLog(@"点击的是%ld",(long)indexPath.row);
            TempMonth.text = [(MonthModel *)mon dateValue].weekdayByLineWithDate;
        }
        if ([self.CalendarViewDelegate respondsToSelector:@selector(changeDateString:)]){
            NSString *deliverString = [dateFormatter stringFromDate:[mon dateValue]];
            [self.CalendarViewDelegate changeDateString:deliverString];
            
            
            //        NSLog(@"传过去的值%@",TempMonth.text);
        }
        
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        
        //判断选中不同row状态时候
        if (SelectedIndex != nil && indexPath.item == SelectedIndex.item) {
            //将选中的和所有索引都加进数组中
            //        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
            if(indexPath == SelectedIndex){
                //            isSelectedItem = !isSelectedItem;
            }else{
                isSelectedItem = !isSelectedItem;
            }
            
            
        }else if (SelectedIndex != nil && indexPath.item != SelectedIndex.item) {
            indexPaths = [NSArray arrayWithObjects:indexPath,SelectedIndex, nil];
            isSelectedItem = YES;
        }
        
        //记下选中的索引
        SelectedIndex = indexPath;
        
        [_collectionView reloadItemsAtIndexPaths:indexPaths];
    }else if(value==1){
        //点击的是未来的时间
        NSLog(@"ceshi");
            [JCAlertView showOneButtonWithTitle:@"" Message:@"不可以点击过去的时间哦" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
    }else if(value==2){
        //点击的是未来的时间
        
        [JCAlertView showOneButtonWithTitle:@"" Message:@"不可以点击未来的时间哦" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
    }


}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.08,
                                         [UIScreen mainScreen].bounds.size.width*0.093);
        flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.7246,
                                                    [UIScreen mainScreen].bounds.size.width*0.07246);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            [UIScreen mainScreen].bounds.size.width*0.56,
                                                                            [UIScreen mainScreen].bounds.size.width*0.88)collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
//        [_collectionView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeaderView"];
        
    }
    return _collectionView;
}


#pragma mark -Private
- (NSUInteger)numberOfDaysInMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
}

- (NSDate *)firstDateOfMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:date];
    comps.day = 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSUInteger)startDayOfWeek:(NSDate *)date
{
    NSCalendar *greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];//Asia/Shanghai
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay
                               fromDate:[self firstDateOfMonth:date]];
    return comps.weekday;
}

- (NSDate *)getLastMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month -= 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSDate *)getNextMonth:(NSDate *)date{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:date];
    comps.month += 1;
    return [greCalendar dateFromComponents:comps];
}

- (NSDate *)dateOfDay:(NSInteger)day{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [greCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *comps = [greCalendar
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:self.tempDate];
    comps.day = day;
    return [greCalendar dateFromComponents:comps];
}



@end

@implementation CalendarHeaderView
//- (instancetype)initWithFrame:(CGRect)frame{
////    if (self = [super initWithFrame:frame]) {
////
////        NSArray *weekArray = [[NSArray alloc] initWithObjects:@"Sun.",@"Mon.",@"Tues.",@"Wed.",@"Thur.",@"Fri.",@"Sat.", nil];
////        for (int i=0; i<weekArray.count; i++) {
////            UILabel *weekLabel = [[UILabel alloc] initWithFrame:
////                                  CGRectMake(i*[UIScreen mainScreen].bounds.size.width*0.1039, -i*[UIScreen mainScreen].bounds.size.width*0.1, [UIScreen mainScreen].bounds.size.width*0.1014, [UIScreen mainScreen].bounds.size.width*0.0725)];
////            weekLabel.textAlignment = NSTextAlignmentCenter;
////            weekLabel.textColor = [UIColor whiteColor];
//////            weekLabel.font = [UIFont systemFontOfSize:13.f];
////            weekLabel.font = [UIFont fontWithName:@"BatikRegular" size:13];
////            weekLabel.text = weekArray[i];
////            [self addSubview:weekLabel];
////        }
////        
////    }
//    return self;
//}
@end



@implementation CalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.5-width*0.5,  self.contentView.frame.size.height*0.5-height*0.5, width, height )];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.layer.masksToBounds = YES;
        dayLabel.font = [UIFont fontWithName:@"BatikRegular" size:16];
        
        [self.contentView addSubview:dayLabel];
        self.dayLabel = dayLabel;
        
        _dayLabelImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                    self.dayLabel.bounds.size.width,
                                                                    self.dayLabel.bounds.size.width)];
        _dayLabelImg.image = [UIImage imageNamed:@"chooseday_icon.png"];
        [self.dayLabel addSubview:_dayLabelImg];
//        _dayLabelImg.hidden = YES;
    }
    return self;
}

-(void)test{

}

- (void)setMonthModel:(MonthModel *)monthModel{
    _monthModel = monthModel;
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",(long)monthModel.dayValue];
    

    if (monthModel.isSelectedDay) {
        _dayLabelImg.hidden = NO;
//        UIImageView *testImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
//                                                                    self.dayLabel.bounds.size.width,
//                                                                    self.dayLabel.bounds.size.width)];
//        testImage.image = [UIImage imageNamed:@"chooseday_icon.png"];
//        [self.dayLabel addSubview:_dayLabelImg];
        self.dayLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:30.0/255.0 alpha:1];
    }else{
//        _dayLabelImg.hidden = YES;
        if(_SelectedDay){
            _dayLabelImg.hidden = NO;
        }else{
            _dayLabelImg.hidden = YES;
        }
    }
}
@end

@implementation MonthModel

@end
