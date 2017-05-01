/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/



#import "AppDelegate.h"
#include "easyar/utility.hpp"
#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <BmobSDK/Bmob.h>
#import "SJDownloadSource.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    _active = true;
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    [Bmob registerWithAppKey:@"f3a5809c57b91e429b38e0b33d7f8090"];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58b311236e27a475ab000722"];
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey =@"6b9542ad873b8738ff52270a99abddfb";
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
     [Bugly startWithAppId:@"f5cf7ac8f6"];
    


    if(![[NSUserDefaults standardUserDefaults]valueForKey:@"First"]){
    SJDownloadSource *downloadSource = [[SJDownloadSource alloc]init];
    [downloadSource initDownloadImage];
    [[NSUserDefaults standardUserDefaults]setValue:@"yes" forKey:@"First"];
    }


    return YES;
}



- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2350730267"  appSecret:@"88db09063f23e0eab5d1eeb147ba320a" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx8873878732f5f8f7" appSecret:@"85e3746156134f41c47fbac2c9625f74" redirectURL:@"http://mobile.umeng.com/social"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105995515"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    (void)application;
    _active = false;
    EasyAR::onPause();
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    (void)application;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    (void)application;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    (void)application;
    _active = true;
    EasyAR::onResume();
    sleep(2.0);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    (void)application;
    _active = false;
}

@end
