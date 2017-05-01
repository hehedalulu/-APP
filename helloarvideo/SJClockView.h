//
//  SJClockView.h
//  拾间
//
//  Created by Wll on 17/2/26.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define angle2radion(angle) ((angle) / 180.0 * M_PI)
// 1秒6度(秒针)
#define perSecondA 6
// 1分钟6度(分针)
#define perMintueA 6
// 1小时30度（时针）
#define perHourA 30
// 每分钟时针转(30 / 60 °)
#define perMinHourA 0.5
@interface SJClockView : UIView{
    CALayer * secondLayer;
    CALayer * mintueLayer;
    CALayer * hourLayer;
}

@end
