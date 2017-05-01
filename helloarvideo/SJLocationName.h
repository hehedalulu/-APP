//
//  SJLocationName.h
//  拾间
//
//  Created by Wll on 17/4/12.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface SJLocationName : NSObject{
}
-(MAPointAnnotation *)BackLocationName:(NSString*)DateString;
@end
