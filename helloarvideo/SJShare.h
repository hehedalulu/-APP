//
//  SJShare.h
//  拾间
//
//  Created by Wll on 17/3/29.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import "JCAlertView.h"
@interface SJShare : NSObject
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType WithImage:(UIImage*)image;
@end
