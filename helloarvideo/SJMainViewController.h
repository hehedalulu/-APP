//
//  SJMainViewController.h
//  拾间
//
//  Created by Wll on 17/1/25.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCalendarView.h"
#import "JCAlertView.h"
#import <BmobSDK/Bmob.h>
@interface SJMainViewController : UIViewController<SJCalendarViewDelegate>{
    UIImageView *launchImage;
    UIImageView *backImage;
}

@end
