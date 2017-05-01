//
//  SJDownloadSource.m
//  拾间
//
//  Created by Wll on 17/4/17.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "SJDownloadSource.h"
#import "SDWebImageManager.h"
#import <BmobSDK/Bmob.h>

@implementation SJDownloadSource

-(void)initDownloadImage{
//    NSDate *now = [NSDate date];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CalendarImage"];
//    [bquery whereKey:@"date" equalTo:prediate];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    bquery.limit = 1000;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count==0) {
        }else{
            for (BmobObject *obj in array) {
                //路牌
                BmobFile *file = (BmobFile*)[obj objectForKey:@"CalendarImg"];
                NSString *date = [NSString stringWithFormat:@"LuPai%@",[obj objectForKey:@"date"]];
                NSURL *tempurl = (NSURL *)file.url;
                
                [[NSUserDefaults standardUserDefaults]setValue:tempurl forKey:date];
                
//                [[SDImageCache sharedImageCache] storeImage:test forKey:@"anUrlString" toDisk:YES];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager loadImageWithURL:tempurl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    NSLog(@"显示当前进度");
                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    NSLog(@"下载完成");
                }];
//                [manager downloadImageWithURL:tempurl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
////                    NSLog(@"显示当前进度");
//                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
////                    NSLog(@"下载完成");
//                    NSLog(@"date%@,url%@",date,tempurl);
//                }];
                
                //背景图
                BmobFile *BackView = (BmobFile*)[obj objectForKey:@"LuPai"];
                NSString *date1 = [NSString stringWithFormat:@"Bg%@",[obj objectForKey:@"date"]];
                NSURL *tempurl1 = (NSURL *)BackView.url;
                
                [[NSUserDefaults standardUserDefaults]setValue:tempurl1 forKey:date1];
                
                SDWebImageManager *manager1 = [SDWebImageManager sharedManager];
                [manager1 loadImageWithURL:tempurl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    NSLog(@"显示当前进度");
                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    NSLog(@"下载完成");
                }];
                
//                [manager1 downloadImageWithURL:tempurl1 options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
////                    NSLog(@"显示当前进度");
//                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
////                    NSLog(@"下载完成");
//                    NSLog(@"BackViewdate%@,url%@",date,tempurl);
//                }];
            }
            
        }
    }];
}

@end
