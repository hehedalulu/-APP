//
//  SJCalendarView.m
//  拾间
//
//  Created by Wll on 17/1/26.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "SJCalendarView.h"
#import "NSDate+Formatter.h"

#define HeaderViewHeight 30
#define WeekViewHeight 40

@implementation SJCalendarView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:71.0/255.0 blue:141.0/255.0 alpha:1];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    
    TempMonth = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0483,
                                                         [UIScreen mainScreen].bounds.size.width*0.1932,
                                                         [UIScreen mainScreen].bounds.size.width*0.7246,
                                                         [UIScreen mainScreen].bounds.size.width*0.1207)];

    self.tempDate = [NSDate date];
    [self getDataDayModel:self.tempDate];
    TempMonth.textColor = [UIColor whiteColor];
    TempMonth.font = [UIFont systemFontOfSize:22];
    TempMonth.text = self.tempDate.yyyyMMddByLineWithDate;
    [self addSubview:TempMonth];
   // self.dateLabel.text = self.tempDate.yyyyMMByLineWithDate;
    [self addChangeMonthGesture];
}


-(void)addChangeMonthGesture{
    UISwipeGestureRecognizer *UPchangeMonthDirection = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonth:)];
    UPchangeMonthDirection.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:UPchangeMonthDirection];
    
    UISwipeGestureRecognizer *DOWNpchangeMonthDirection = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonth:)];
    DOWNpchangeMonthDirection.direction= UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:DOWNpchangeMonthDirection];
}

//判断上下滑动Z
-(void)changeMonth:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"日历view中上滑手势");
        self.tempDate = [self getLastMonth:self.tempDate];
        TempMonth.text = self.tempDate.yyyyMMddByLineWithDate;
        [self getDataDayModel:self.tempDate];
    }
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"日历view中下滑手势");            
        self.tempDate = [self getNextMonth:self.tempDate];
        TempMonth.text = self.tempDate.yyyyMMddByLineWithDate;
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


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    cell.dayLabel.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor whiteColor];
    id mon = self.dayModelArray[indexPath.row];
    if ([mon isKindOfClass:[MonthModel class]]) {
        cell.monthModel = (MonthModel *)mon;
    }else{
        cell.dayLabel.text = @"";
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CalendarHeaderView" forIndexPath:indexPath];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id mon = self.dayModelArray[indexPath.row];
//    NSLog(@"点击的是%ld",(long)(indexPath.row+1)%7);
//    NSLog(@"点击的行数是%d",(int)(indexPath.row+1)/7);
//    UIView *cellBackgroundView = [[UIView alloc]init];
//    int cellX = (indexPath.row+1)%7;
////    if (cellX == 0) {
////        cellX = 6;
////    }else{
////    }
//    int cellY = (int)(indexPath.row+1)/7;
//    cellBackgroundView.frame = CGRectMake(cellX*42-42, (cellY+1)*42-5, 42, 42);
//    cellBackgroundView.backgroundColor = [UIColor grayColor];
//    [cellBackgroundView.layer setCornerRadius:21];
//    [collectionView addSubview:cellBackgroundView];
    if ([mon isKindOfClass:[MonthModel class]]) {
        NSLog(@"点击的是%ld",(long)indexPath.row);
        TempMonth.text = [(MonthModel *)mon dateValue].yyyyMMddByLineWithDate;
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.1014,
                                         [UIScreen mainScreen].bounds.size.width*0.1014);
        flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.7246,
                                                    [UIScreen mainScreen].bounds.size.width*0.07246);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.width*0.483,
                                                                            [UIScreen mainScreen].bounds.size.width*0.7246,
                                                                            [UIScreen mainScreen].bounds.size.height - 64 - WeekViewHeight) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
        [_collectionView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeaderView"];
        
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
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *weekArray = [[NSArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
        for (int i=0; i<weekArray.count; i++) {
            UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*43, 0, 42, 30)];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            weekLabel.textColor = [UIColor grayColor];
            weekLabel.font = [UIFont systemFontOfSize:13.f];
            weekLabel.text = weekArray[i];
            [self addSubview:weekLabel];
        }
        
    }
    return self;
}
@end



@implementation CalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.5-width*0.5,  self.contentView.frame.size.height*0.5-height*0.5, width, height )];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.layer.masksToBounds = YES;
        dayLabel.layer.cornerRadius = height * 0.5;
        
        [self.contentView addSubview:dayLabel];
        self.dayLabel = dayLabel;
    }
    return self;
}

- (void)setMonthModel:(MonthModel *)monthModel{
    _monthModel = monthModel;
    self.dayLabel.text = [NSString stringWithFormat:@"%02ld",monthModel.dayValue];
    if (monthModel.isSelectedDay) {
        self.dayLabel.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:71.0/255.0 blue:141.0/255.0 alpha:1];
    }
}
@end

@implementation MonthModel

@end
