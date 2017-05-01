//
//  SJClockView.m
//  拾间
//
//  Created by Wll on 17/2/26.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "SJClockView.h"

@implementation SJClockView



- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
    // 添加时针
    [self setUpHourLayer];
    // 添加分针
    [self setUpMinuteLayer];
    // 添加秒针
    [self setUpSecondLayer];
    //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];

}

- (void)timeChange{
    
    // 获取当前系统时间
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour  fromDate:[NSDate date]];
    
    CGFloat second = cmp.second;
    
    CGFloat secondA = (second * perSecondA) ;
    
    NSInteger minute = cmp.minute;
    
    CGFloat mintuteA = minute * perMintueA ;
    
    NSInteger hour = cmp.hour;
    
    CGFloat hourA = hour * perHourA  + minute * perMinHourA;
    
    secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    mintueLayer.transform = CATransform3DMakeRotation(angle2radion(mintuteA), 0, 0, 1);
    
    hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}

#pragma mark - 添加秒针

- (void)setUpSecondLayer{
    
    if (!secondLayer) {
        CALayer * secondL = [CALayer layer];
        
        secondL.backgroundColor = [UIColor redColor].CGColor ;
        
        // 设置锚点
        
        secondL.anchorPoint = CGPointMake(0.5, 1);
        
        secondL.position = CGPointMake(self.bounds.size.width* 0.5, self.bounds.size.width * 0.5);
        
        secondL.bounds = CGRectMake(0, 0, 0.8, [UIScreen mainScreen].bounds.size.width * 0.06);
        
        
        [self.layer addSublayer:secondL];
        
        secondLayer = secondL;
    }

}

#pragma mark - 添加分针

- (void)setUpMinuteLayer{
    if (!mintueLayer) {
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor whiteColor].CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 1, [UIScreen mainScreen].bounds.size.width * 0.053);
    
    layer.cornerRadius = 4;
    
    [self.layer addSublayer:layer];
    
    mintueLayer = layer;
    }
}

#pragma mark - 添加时针

- (void)setUpHourLayer{
    if (!hourLayer) {
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = [UIColor whiteColor].CGColor ;
    // 设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 1.5, [UIScreen mainScreen].bounds.size.width * 0.04);
    
    layer.cornerRadius = 4;
    
    [self.layer addSublayer:layer];
    hourLayer = layer;
    }
}


@end
