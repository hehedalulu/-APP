//
//  SJMainViewController.m
//  拾间
//
//  Created by Wll on 17/1/25.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//
#import <POP/POP.h>
#import "SJMainViewController.h"
#import "JCAlertView.h"
#import "DHGuidePageHUD.h"
#import "NSDate+Formatter.h"
#import "SJShare.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SJShareImage.h"
#import "SJMapViewController.h"

@interface SJMainViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>{
    UIScreenEdgePanGestureRecognizer *leftGesture;
    UIView *upView;
    UIImageView *originalView;
    UIScrollView *shareView;
    UIImageView *originalView2;
    UILabel *testMonthlabel;
    UILabel *testDaylabel;
    NSDate  *today;
    UILabel *todaylabel;
    NSDateFormatter *newFormatter;
    
    UIView *tempView;
    UIView *backgroundView;
    UIPanGestureRecognizer *dismissCalendar;
    
    UISwipeGestureRecognizer *UPchangeMonthDirection;
    UISwipeGestureRecognizer *DOWNpchangeMonthDirection;
    
    UISwipeGestureRecognizer *UPchange;
    UISwipeGestureRecognizer *Downchange;
    
    SJShareImage *ShareBtn;
    UIImageView *todayImg;
    UIButton *showcamerabtn;
    //分享
    SJShare *sjshare;
    
    
}
@property (strong, nonatomic) UIImageView *DayShowImage;
@property (weak, nonatomic) IBOutlet SJCalendarView *SJCalendarVIew;
@end

@implementation SJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,
                                                            [UIScreen mainScreen].bounds.size.width,
                                                             [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:backgroundView];
    
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstopen"];
    if ((!key)||[key isEqualToString:@"NO"]) {
        // 静态引导页
        [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"firstopen"];
        [self setStaticGuidePage];
        NSLog(@"进入引导页面");
        [self drawMainView];
    }else{
        [self setLaunchImage];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    sjshare = [[SJShare alloc]init];
    
}

#pragma mark - 上层栏UI
-(void)drawMainView{
    if (!self.DayShowImage) {
        self.DayShowImage = [[UIImageView alloc]init];
        self.DayShowImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                             [UIScreen mainScreen].bounds.size.width*0.0187,
                                             [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                             [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
        [backgroundView addSubview:_DayShowImage];
        
    }
    
    
    self.SJCalendarVIew.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,
                                           0,
                                           [UIScreen mainScreen].bounds.size.width*0.7246,
                                           [UIScreen mainScreen].bounds.size.height);
    self.SJCalendarVIew.userInteractionEnabled = YES;
    self.SJCalendarVIew.CalendarViewDelegate = self;
    [self.view addSubview:_SJCalendarVIew];
    
    
    //边缘手势
    newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //    today = [newFormatter dateFromString:@"2017-04-25"];
    //今天
    today = [NSDate date];
    
    [self drawUpView];
    [self setCalendarImage];
    [self addChangeMonthGesture];
    dismissCalendar = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeCalendarView:)];
    dismissCalendar.delegate = self;
    [self addedgeGesture];
    
    UPchange = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonthView:)];
    UPchange.delegate = self;
    UPchange.direction = UISwipeGestureRecognizerDirectionUp;
    
    
    Downchange = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonthView:)];
    Downchange.delegate = self;
    Downchange.direction= UISwipeGestureRecognizerDirectionDown;
    
    [self initHiddenlabel];
    [self drawShareView];
}
- (void)drawUpView{
    if (!upView) {
        upView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                                         [UIScreen mainScreen].bounds.size.width*0.035,
                                                         [UIScreen mainScreen].bounds.size.width,
                                                         [UIScreen mainScreen].bounds.size.width*0.08)];
        [backgroundView addSubview:upView];
        
        todayImg = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.053,
                                                                             0,
                                                                             [UIScreen mainScreen].bounds.size.width*0.176,
                                                                             [UIScreen mainScreen].bounds.size.width*0.08)];
        todayImg.image = [UIImage imageNamed:@"todayimage.png"];
        todayImg.backgroundColor = [UIColor clearColor];
        [upView addSubview:todayImg];
        
        todaylabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.253,
                                                              0,
                                                              [UIScreen mainScreen].bounds.size.width*0.493,
                                                              [UIScreen mainScreen].bounds.size.width*0.08)];
        todaylabel.textColor = [UIColor colorWithRed:0.0/255.0 green:61.0/255.0 blue:110.0/255.0 alpha:1];
        todaylabel.textAlignment = NSTextAlignmentCenter;
        todaylabel.font = [UIFont fontWithName:@"BatikRegular" size:21];
        todaylabel.text = today.weekdayByLineWithDate;
        [upView addSubview:todaylabel];
        
        showcamerabtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.82,
                                                                             -[UIScreen mainScreen].bounds.size.width*0.01,
                                                                             [UIScreen mainScreen].bounds.size.width*0.12,
                                                                             [UIScreen mainScreen].bounds.size.width*0.096)];
        [showcamerabtn setBackgroundImage:[UIImage imageNamed:@"showcamerabtn.png"] forState:UIControlStateNormal];
        
        
        [upView addSubview:showcamerabtn];
        [showcamerabtn addTarget:self action:@selector(PushToARView) forControlEvents:UIControlEventTouchUpInside];

        
    }
}


-(void)drawShareView{
    shareView = [[UIScrollView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                                            [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                                            [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                            [UIScreen mainScreen].bounds.size.width*0.213)];
    shareView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, 0);
    shareView.delegate = self;
    shareView.showsHorizontalScrollIndicator = NO;
    shareView.showsVerticalScrollIndicator = NO;
    shareView.bounces = NO;
    shareView.delaysContentTouches = NO;
    shareView.userInteractionEnabled = YES;
    shareView.exclusiveTouch = YES;
    [shareView setDelaysContentTouches:NO];
    shareView.scrollEnabled = YES;
    [self.view addSubview:shareView];
    
    originalView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                                [UIScreen mainScreen].bounds.size.width*0.195)];
    originalView.userInteractionEnabled = YES;
    NSString *prediate = [newFormatter stringFromDate:today];
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CalendarImage"];
    [bquery whereKey:@"date" equalTo:prediate];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count==0) {   
        }else{
            BmobObject *ceshi = [array objectAtIndex:0];
            BmobFile *file = (BmobFile*)[ceshi objectForKey:@"CalendarImg"];
            NSURL *tempurl = (NSURL *)file.url;
            [originalView sd_setImageWithURL:tempurl placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];
            NSLog(@"url地址%@",tempurl);
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager loadImageWithURL:tempurl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                NSLog(@"显示当前进度");
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                NSLog(@"下载完成");
            }];
//            [manager loadImageWithURL:tempurl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            }];
        }
    }];
    [shareView addSubview:originalView];
    
    UIButton *clicktoMap = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.78, 0,
                                                                    [UIScreen mainScreen].bounds.size.width*0.22,
                                                                     [UIScreen mainScreen].bounds.size.width*0.195)];
    clicktoMap.backgroundColor = [UIColor clearColor];
    [originalView addSubview:clicktoMap];
//    int compare = [self LaterThanToday:<#(NSDate *)#> withOtherDate:<#(NSDate *)#>]
//    if ([today earlierDate:[newFormatter dateFromString:@"2017-04-23"]]) {
//        NSLog(@"早");
//    }else{
    [clicktoMap addTarget:self action:@selector(changeToMap) forControlEvents:UIControlEventTouchUpInside];
//        NSLog(@"晚");
//    }
    
    
    originalView2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0,
                                                                             [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187,
                                                                             [UIScreen mainScreen].bounds.size.width*0.213)];
    originalView2.userInteractionEnabled = YES;
    [shareView addSubview:originalView2];

    NSMutableArray *imageArray = [NSMutableArray array];

    [imageArray addObject:@"sinaBtn.png"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        //QQ
        [imageArray addObject:@"QzoneBtn.png"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        //微信
        [imageArray addObject:@"wechatBtn.png"];
        [imageArray addObject:@"friendCircleBtn.png"];
    }
    
    [imageArray addObject:@"downloadBtn.png"];

    
    for(int i=0;i< imageArray.count;i++){
        ShareBtn = [[SJShareImage alloc]init];
        ShareBtn.userInteractionEnabled = YES;
        int originalX = [UIScreen mainScreen].bounds.size.width*0.087;
        ShareBtn.frame = CGRectMake(originalX+i*[UIScreen mainScreen].bounds.size.width*0.173,
                                    [UIScreen mainScreen].bounds.size.width*0.050,
                                    [UIScreen mainScreen].bounds.size.width*0.106,
                                    [UIScreen mainScreen].bounds.size.width*0.106);
        NSString *imageName = [imageArray objectAtIndex:i];
        ShareBtn.backgroundColor = [UIColor clearColor];
        ShareBtn.image = [UIImage imageNamed:imageName];
        ShareBtn.tag = i;
        ShareBtn.SJShareTitle = [imageArray objectAtIndex:i];
        [originalView2 addSubview:ShareBtn];
        if ([ShareBtn.SJShareTitle isEqualToString:@"sinaBtn.png"]) {
            UITapGestureRecognizer *tapit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareItToWeibo)];
            [ShareBtn addGestureRecognizer:tapit];
        }
        if ([ShareBtn.SJShareTitle isEqualToString:@"QzoneBtn.png"]) {
            UITapGestureRecognizer *tapit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareToQzone)];
            [ShareBtn addGestureRecognizer:tapit];
        }
        if ([ShareBtn.SJShareTitle isEqualToString:@"wechatBtn.png"]) {
            UITapGestureRecognizer *tapit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareToWeChat)];
            [ShareBtn addGestureRecognizer:tapit];
        }
        if ([ShareBtn.SJShareTitle isEqualToString:@"friendCircleBtn.png"]) {
            UITapGestureRecognizer *tapit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShareToFriendCircle)];
            [ShareBtn addGestureRecognizer:tapit];
        }
        if ([ShareBtn.SJShareTitle isEqualToString:@"downloadBtn.png"]) {
            UITapGestureRecognizer *tapit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SaveImageViewinLocal)];
            [ShareBtn addGestureRecognizer:tapit];
        }
    }
}

-(void)changeToMap{
    SJMapViewController *sjMapVC = [[SJMapViewController alloc]init];
    sjMapVC.SJMapString = [newFormatter stringFromDate:today];
    [self presentViewController:sjMapVC animated:YES completion:nil];
//    [self.navigationController presentViewController:sjMapVC animated:YES completion:nil];
}

#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"qidongye_view_01.png",@"qidongye_view_02.png",@"qidongye_view_03.png",@"qidongye_view_04.png"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO ];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 设置分享
//保存到本地
-(void)SaveImageViewinLocal{
    UIImage *togetherImage = [self saveImage];
    UIImageWriteToSavedPhotosAlbum(togetherImage, nil, nil, nil);//然后将该图片保存到图片
    [JCAlertView showOneButtonWithTitle:@"" Message:@"图片已经保存到本地" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
}
//分享到微博
-(void)ShareItToWeibo{
    UIImage *togetherImage = [self saveImage];
    NSLog(@"点击分享");
    [sjshare shareImageToPlatformType:0 WithImage:togetherImage];
}
//分享到微信聊天
-(void)ShareToWeChat{
    UIImage *togetherImage = [self saveImage];
//    NSLog(@"%@",togetherImage);
    [sjshare shareImageToPlatformType:1 WithImage:togetherImage];
}
//分享到朋友圈
-(void)ShareToFriendCircle{
    UIImage *togetherImage = [self saveImage];
    NSLog(@"点击分享");
    [sjshare shareImageToPlatformType:2 WithImage:togetherImage];
}
-(void)ShareToQzone{
    UIImage *togetherImage = [self saveImage];
    NSLog(@"点击分享");
    [sjshare shareImageToPlatformType:5 WithImage:togetherImage];
}
     
-(UIImage *)saveImage{
    NSLog(@"点击了button");
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        UIImage *backshareview = [UIImage imageNamed:@"backshareview.png"];
        UIImage *tempImage1 = self.DayShowImage.image;
        UIImage *tempImage2 = originalView.image;
        UIImage *imagetodayLabel = [self setTitleLabelImage];
        UIImage *shareARBtn = [UIImage imageNamed:@"showcamerabtn.png"];
    
    
        UIGraphicsBeginImageContextWithOptions(size,YES, [UIScreen mainScreen].scale);
    
        [backshareview drawInRect:CGRectMake(0,
                                             0,
                                      [UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.height)];
    

    
        [tempImage1 drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0765,
                                          [UIScreen mainScreen].bounds.size.width*0.0187,
                                          [UIScreen mainScreen].bounds.size.width*0.847,
                                          ([UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2)*0.88)];
    
        [tempImage2 drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0765,
                                          [UIScreen mainScreen].bounds.size.width*0.796*0.88,
                                          [UIScreen mainScreen].bounds.size.width*0.847,
                                          [UIScreen mainScreen].bounds.size.width*0.195*0.88)];
    
        [todayImg.image drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.1,
                                              [UIScreen mainScreen].bounds.size.width*0.035,
                                              [UIScreen mainScreen].bounds.size.width*0.176*0.88,
                                              [UIScreen mainScreen].bounds.size.width*0.08*0.88)];
    
        [imagetodayLabel drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.2717,
                                               [UIScreen mainScreen].bounds.size.width*0.035,
                                               [UIScreen mainScreen].bounds.size.width*0.493*0.88,
                                               [UIScreen mainScreen].bounds.size.width*0.08*0.88)];
    
    
        [shareARBtn drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.78,
                                          [UIScreen mainScreen].bounds.size.width*0.025,
                                          [UIScreen mainScreen].bounds.size.width*0.12*0.88,
                                          [UIScreen mainScreen].bounds.size.width*0.096*0.88)];
    
    
        UIImage *togetherImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
    return  togetherImage;
}


//截图头部的title照片
-(UIImage*)setTitleLabelImage{
    CGSize size = todaylabel.frame.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [todaylabel.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
    
}


-(void)setCalendarImage{
    NSString *prediate = [newFormatter stringFromDate:today];
    NSLog(@"今天的日期%@",prediate);
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CalendarImage"];
    [bquery whereKey:@"date" equalTo:prediate];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count == 0) {
            [self.DayShowImage setImage:[UIImage imageNamed:@"deja-vu_2017-01-28"]];
        }else{
            NSString *BgString = [NSString stringWithFormat:@"Bg%@",prediate];
            if ([[NSUserDefaults standardUserDefaults]valueForKey:BgString]) {
                NSString *url = [[NSUserDefaults standardUserDefaults]valueForKey:BgString];
                [self.DayShowImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached progress:nil completed:nil];
            }else{
                BmobObject *ceshi = [array objectAtIndex:0];
                BmobFile *file = (BmobFile*)[ceshi objectForKey:@"LuPai"];
                NSURL *tempurl = (NSURL *)file.url;
//                NSLog(@"%@",tempurl);
                [self.DayShowImage sd_setImageWithURL:tempurl placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];

            }

        }
    }];
}

-(void)PushToARView{
    [self performSegueWithIdentifier:@"PushToARView" sender:nil];
}


-(void)addedgeGesture{
    leftGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(showCalendarView:)];
//    leftGesture.delegate = self;
    leftGesture.edges = UIRectEdgeLeft;
        //[tapdismiss requireGestureRecognizerToFail:ChangeMonthDirection];
    [self.view addGestureRecognizer:leftGesture];
}


-(void)showCalendarView:(UIPanGestureRecognizer *)gesture{
    [self.view removeGestureRecognizer:UPchangeMonthDirection];
    [self.view removeGestureRecognizer:DOWNpchangeMonthDirection];
    
    [self.view addGestureRecognizer:dismissCalendar];
    [self.view addGestureRecognizer:UPchange];
    [self.view addGestureRecognizer:Downchange];
    [dismissCalendar requireGestureRecognizerToFail:UPchange];
    [dismissCalendar requireGestureRecognizerToFail:Downchange];
    
    //        CGPoint nowpoint = self.center;
    
    if (self.DayShowImage.frame.origin.x == [UIScreen mainScreen].bounds.size.width*0.0187) {
        CGPoint changex = [gesture translationInView:self.view.superview];
        if (changex.x < 0) {//开始状态不能左滑
            return;
        }
    }
    
    CGPoint changeX = [gesture translationInView:self.DayShowImage.superview];
    NSLog(@"偏移量%f",changeX.x);

    if (gesture.state == UIGestureRecognizerStateBegan||gesture.state == UIGestureRecognizerStateChanged) {
        
        CGFloat tempX = self.DayShowImage.frame.origin.x + changeX.x;// 算出更新的 x
            self.SJCalendarVIew.frame = CGRectMake(tempX-[UIScreen mainScreen].bounds.size.width, 0,
                                                   [UIScreen mainScreen].bounds.size.width,
                                                   [UIScreen mainScreen].bounds.size.height);
            self.DayShowImage.frame = CGRectMake(tempX,
                                                 [UIScreen mainScreen].bounds.size.width*0.0187,
                                                 [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                 [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
            upView.frame = CGRectMake(tempX,
                                                 [UIScreen mainScreen].bounds.size.width*0.035,
                                                 [UIScreen mainScreen].bounds.size.width,
                                                 [UIScreen mainScreen].bounds.size.width*0.08);
            shareView.frame = CGRectMake(tempX,
                                         [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                         [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                         [UIScreen mainScreen].bounds.size.width*0.213);
        
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        NSLog(@"当前的x坐标%f",self.SJCalendarVIew.frame.origin.x);
        if ((self.DayShowImage.frame.origin.x > 0)&&(self.DayShowImage.frame.origin.x < [UIScreen mainScreen].bounds.size.width/2)) {
            [UIView animateWithDuration:0.5 animations:^{
                self.SJCalendarVIew.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0,
                                                       [UIScreen mainScreen].bounds.size.width,
                                                       [UIScreen mainScreen].bounds.size.height);
                self.DayShowImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                                     [UIScreen mainScreen].bounds.size.width*0.0187,
                                                     [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                     [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
                upView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                          [UIScreen mainScreen].bounds.size.width*0.035,
                                          [UIScreen mainScreen].bounds.size.width,
                                          [UIScreen mainScreen].bounds.size.width*0.08);
                shareView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                             [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                             [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                             [UIScreen mainScreen].bounds.size.width*0.213);
                
            }];
            //去除手势
            [self.view removeGestureRecognizer:dismissCalendar];
            [self.view addGestureRecognizer:UPchangeMonthDirection];
            [self.view addGestureRecognizer:DOWNpchangeMonthDirection];
            [self.view removeGestureRecognizer:UPchange];
            [self.view removeGestureRecognizer:Downchange];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                self.SJCalendarVIew.frame = CGRectMake(0, 0,
                                                       [UIScreen mainScreen].bounds.size.width,
                                                       [UIScreen mainScreen].bounds.size.height);
                self.DayShowImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width+[UIScreen mainScreen].bounds.size.width*0.0187,
                                                     [UIScreen mainScreen].bounds.size.width*0.0187,
                                                     [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                     [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
                upView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width+[UIScreen mainScreen].bounds.size.width*0.0187,
                                          [UIScreen mainScreen].bounds.size.width*0.035,
                                          [UIScreen mainScreen].bounds.size.width,
                                          [UIScreen mainScreen].bounds.size.width*0.08);
                shareView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width+[UIScreen mainScreen].bounds.size.width*0.0187,
                                             [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                             [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                             [UIScreen mainScreen].bounds.size.width*0.213);
            }];
            [self performSelector:@selector(closeDayImage) withObject:nil afterDelay:0.5];
        }
    }
    [gesture setTranslation:CGPointZero inView:backgroundView.superview];
}
-(void)closeDayImage{
    [self.DayShowImage removeGestureRecognizer:leftGesture];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint curP = [touch locationInView:backgroundView];
    NSLog(@"触摸的点%f,%f",curP.x,curP.y);
    NSLog(@"触摸的view%@",touch.view);
        if ([touch.view isKindOfClass:[UICollectionViewCell class]]) {
            NSLog(@"上下滑动日历view");
            return NO;
        }
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if(curP.x < 300){
            NSLog(@"点击日历View");
            return NO;
            
        }
    }if ([touch.view isKindOfClass:[UIButton class]]) {
        NSLog(@"点击了按钮");
        return NO;
    }if ([touch.view isKindOfClass:[UIScrollView class]]) {
        NSLog(@"颠倒了scrollview");
        return NO;
    }

    return YES;

}


-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self performSelector:@selector(returnRightOffset) withObject:nil afterDelay:0.2];
}

-(void)returnRightOffset{
    double cOffset = shareView.contentOffset.x ;
    int page;
    NSLog(@"偏移%f",cOffset);
    if (cOffset < [UIScreen mainScreen].bounds.size.width/2) {
         page = 0;
    }else{
         page = 1;
    }
    CGFloat offsetX = page  * [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.5 animations:^{
        shareView.contentOffset = CGPointMake(offsetX, 0);
    }];
    
}

#pragma mark - 滑动
//上下滑动切换月份
-(void)addChangeMonthGesture{
    UPchangeMonthDirection = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonth:)];
    UPchangeMonthDirection.direction = UISwipeGestureRecognizerDirectionUp;
    UPchangeMonthDirection.delegate = self;
    [backgroundView addGestureRecognizer:UPchangeMonthDirection];

    DOWNpchangeMonthDirection = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonth:)];
    DOWNpchangeMonthDirection.direction= UISwipeGestureRecognizerDirectionDown;
    DOWNpchangeMonthDirection.delegate = self;
    [backgroundView addGestureRecognizer:DOWNpchangeMonthDirection];
}

//判断上下滑动
-(void)changeMonth:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        today = [NSDate dateWithTimeInterval:24*60*60 sinceDate:today];
        NSString *todayString = [newFormatter stringFromDate:today];
        NSLog(@"日期是是是是%@",todayString);
        //如果是明天就显示别的
        NSDate *now = [NSDate date];
        NSDate *tomorrow = [NSDate dateWithTimeInterval:24*60*60 sinceDate:now];
        NSString *tomorrowString = [newFormatter stringFromDate:tomorrow];
        
        NSDate *theDayAfterTomorrow = [NSDate dateWithTimeInterval:24*60*60 sinceDate:tomorrow];
        NSString *theDayATString = [newFormatter stringFromDate:theDayAfterTomorrow];
        
        if ([todayString isEqualToString:tomorrowString]||[todayString isEqualToString:theDayATString]) {
            shareView.hidden = YES;
            upView.hidden = YES;
            self.DayShowImage.image = [UIImage imageNamed:@"mingtian.png"];
            today = tomorrow;
        }else{
            shareView.hidden = NO;
            upView.hidden = NO;
            self.DayShowImage.image = nil;
            //背景日历View
            NSString *prediate = [newFormatter stringFromDate:today];
//            BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CalendarImage"];
//            [bquery whereKey:@"date" equalTo:prediate];
//            bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
//            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                BmobObject *ceshi = [array objectAtIndex:0];
//                BmobFile *file = (BmobFile*)[ceshi objectForKey:@"LuPai"];
//                NSURL *tempurl = (NSURL *)file.url;
            NSString *BgString = [NSString stringWithFormat:@"Bg%@",prediate];
            NSString *url = [[NSUserDefaults standardUserDefaults]valueForKey:BgString];
            [self.DayShowImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached progress:nil completed:nil];
//            }];
            //shareView
//            BmobQuery   *bquery1 = [BmobQuery queryWithClassName:@"CalendarImage"];
//            [bquery1 whereKey:@"date" equalTo:prediate];
//            bquery1.cachePolicy = kBmobCachePolicyNetworkElseCache;
//            [bquery1 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                BmobObject *ceshi = [array objectAtIndex:0];
//                BmobFile *file = (BmobFile*)[ceshi objectForKey:@"CalendarImg"];
//                NSURL *tempurl = (NSURL *)file.url;
            NSString *LuPaiString = [NSString stringWithFormat:@"LuPai%@",prediate];
            NSString *url1 = [[NSUserDefaults standardUserDefaults]valueForKey:LuPaiString];
//            [originalView sd_setImageWithURL:[NSURL URLWithString:url1]  placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];
//                NSLog(@"url地址%@",tempurl);
            [originalView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached progress:nil completed:nil];
//            }];
            
            [UIView animateWithDuration:0.2 animations:^{
                self.DayShowImage.alpha = 0;
                shareView.alpha = 0;
                upView.alpha = 0;
                [self.view removeGestureRecognizer:UPchangeMonthDirection];
                [self.view removeGestureRecognizer:DOWNpchangeMonthDirection];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.DayShowImage.alpha = 1;
                    shareView.alpha = 1;
                    upView.alpha = 1;
                } completion:^(BOOL finished) {
                    [self.view addGestureRecognizer:UPchangeMonthDirection];
                    [self.view addGestureRecognizer:DOWNpchangeMonthDirection];
                }];
            }];
            todaylabel.text = today.weekdayByLineWithDate;
        }

        NSLog(@"上滑手势");
    }
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {

        shareView.hidden = NO;
        upView.hidden = NO;
        self.DayShowImage.image = nil;
        today = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:today];
        NSString *todayString = [newFormatter stringFromDate:today];
        
        if ([todayString isEqualToString:@"2017-03-08"]){
            shareView.hidden = YES;
            upView.hidden = YES;
            self.DayShowImage.image = [UIImage imageNamed:@"mingtian.png"];
            NSString *DateString308 = @"2017-03-08";
            today = [newFormatter dateFromString:DateString308];
        }else{
            NSString *prediate = [newFormatter stringFromDate:today];
            NSString *BgString = [NSString stringWithFormat:@"Bg%@",prediate];
            NSString *url = [[NSUserDefaults standardUserDefaults]valueForKey:BgString];
            [self.DayShowImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached progress:nil completed:nil];
            
            NSString *LuPaiString = [NSString stringWithFormat:@"LuPai%@",prediate];
            NSString *url1 = [[NSUserDefaults standardUserDefaults]valueForKey:LuPaiString];
            [originalView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached progress:nil completed:nil];
            //背景View
//            BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CalendarImage"];
//            [bquery whereKey:@"date" equalTo:prediate];
//            bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
//            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                BmobObject *ceshi = [array objectAtIndex:0];
//                BmobFile *file = (BmobFile*)[ceshi objectForKey:@"LuPai"];
//                NSURL *tempurl = (NSURL *)file.url;
//                [self.DayShowImage sd_setImageWithURL:tempurl placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];
//            }];
            
            //shareView
//            BmobQuery   *bquery1 = [BmobQuery queryWithClassName:@"CalendarImage"];
//            [bquery1 whereKey:@"date" equalTo:prediate];
//            bquery1.cachePolicy = kBmobCachePolicyNetworkElseCache;
//            [bquery1 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                BmobObject *ceshi = [array objectAtIndex:0];
//                BmobFile *file = (BmobFile*)[ceshi objectForKey:@"CalendarImg"];
//                NSURL *tempurl = (NSURL *)file.url;
//                [originalView sd_setImageWithURL:tempurl placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];
//                
//                NSLog(@"url地址%@",tempurl);
//            }];
            
            [UIView animateWithDuration:0.2 animations:^{
                self.DayShowImage.alpha = 0;
                shareView.alpha = 0;
                upView.alpha = 0;
                [self.view removeGestureRecognizer:UPchangeMonthDirection];
                [self.view removeGestureRecognizer:DOWNpchangeMonthDirection];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.DayShowImage.alpha = 1;
                    shareView.alpha = 1;
                    upView.alpha = 1;
                } completion:^(BOOL finished) {
                    [self.view addGestureRecognizer:UPchangeMonthDirection];
                    [self.view addGestureRecognizer:DOWNpchangeMonthDirection];
                }];
            }];
            todaylabel.text = today.weekdayByLineWithDate;
            NSLog(@"下滑手势");
        }
    }
}

//左右滑动CalendarView
-(void)changeCalendarView:(UIPanGestureRecognizer *)gesture{
    //        CGPoint nowpoint = self.center;
    CGPoint changeX = [gesture translationInView:self.SJCalendarVIew.superview];
    NSLog(@"偏移量%f",changeX.x);
    if (gesture.state == UIGestureRecognizerStateBegan||gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat tempX = self.SJCalendarVIew.frame.origin.x + changeX.x;// 算出更新的 x
        if (tempX>0||tempX<-[UIScreen mainScreen].bounds.size.width) {
            return;
        }else{
            self.SJCalendarVIew.frame = CGRectMake(tempX, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            self.DayShowImage.frame = CGRectMake(tempX+[UIScreen mainScreen].bounds.size.width,
                                                 [UIScreen mainScreen].bounds.size.width*0.0187,
                                                 [UIScreen mainScreen].bounds.size.width,
                                                 [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
            upView.frame = CGRectMake(tempX+[UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.width*0.035,
                                      [UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.width*0.08);
            shareView.frame = CGRectMake(tempX+[UIScreen mainScreen].bounds.size.width,
                                         [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                         [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                         [UIScreen mainScreen].bounds.size.width*0.213);

        }
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        NSLog(@"当前的x坐标%f",self.SJCalendarVIew.frame.origin.x);
                if ((self.SJCalendarVIew.frame.origin.x > -[UIScreen mainScreen].bounds.size.width)&&(self.SJCalendarVIew.frame.origin.x < -[UIScreen mainScreen].bounds.size.width/2)) {
                    [UIView animateWithDuration:0.5 animations:^{
                    self.SJCalendarVIew.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0,
                                                           [UIScreen mainScreen].bounds.size.width,
                                                           [UIScreen mainScreen].bounds.size.height);
                    self.DayShowImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                                         [UIScreen mainScreen].bounds.size.width*0.0187,
                                                         [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                         [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
                    upView.frame = CGRectMake(0,
                                              [UIScreen mainScreen].bounds.size.width*0.035,
                                              [UIScreen mainScreen].bounds.size.width,
                                              [UIScreen mainScreen].bounds.size.width*0.08);
                    shareView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0187,
                                                 [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                                 [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                 [UIScreen mainScreen].bounds.size.width*0.213);
            
                }];
                //去除手势
                [self.view removeGestureRecognizer:dismissCalendar];
                [self.view addGestureRecognizer:UPchangeMonthDirection];
                [self.view addGestureRecognizer:DOWNpchangeMonthDirection];
                [backgroundView addGestureRecognizer:leftGesture];
                [self.view removeGestureRecognizer:UPchange];
                [self.view removeGestureRecognizer:Downchange];
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    self.SJCalendarVIew.frame = CGRectMake(0, 0,
                                                           [UIScreen mainScreen].bounds.size.width,
                                                           [UIScreen mainScreen].bounds.size.height);
                    self.DayShowImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width,
                                                         [UIScreen mainScreen].bounds.size.width*0.0187,
                                                         [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*0.0187*2,
                                                         [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.0187*2);
                    upView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width,
                                              [UIScreen mainScreen].bounds.size.width*0.035,
                                              [UIScreen mainScreen].bounds.size.width,
                                              [UIScreen mainScreen].bounds.size.width*0.08);
                    shareView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width,
                                                 [UIScreen mainScreen].bounds.size.width*0.815-[UIScreen mainScreen].bounds.size.width*0.0187,
                                                 [UIScreen mainScreen].bounds.size.width,
                                                 [UIScreen mainScreen].bounds.size.width*0.213);
                }];
            }
    }
    [gesture setTranslation:CGPointZero inView:self.SJCalendarVIew.superview];
}
//上下滑动
-(void)changeMonthView:(UISwipeGestureRecognizer*)gesture{
    [self.SJCalendarVIew changeMonthLabel:gesture];
}

-(void)initHiddenlabel{
    testMonthlabel = [[UILabel alloc]init];
    testMonthlabel.frame = CGRectMake(self.DayShowImage.bounds.size.width*0.6,
                                      self.DayShowImage.bounds.size.width*0.10,
                                      self.DayShowImage.bounds.size.width*0.5,
                                      self.DayShowImage.bounds.size.width*0.2);
//    testMonthlabel.text = @"一月";
    testMonthlabel.font = [UIFont systemFontOfSize:40];
    testMonthlabel.textColor = [UIColor grayColor];
    testMonthlabel.hidden = YES;
    [self.DayShowImage addSubview:testMonthlabel];
    
    testDaylabel = [[UILabel alloc]init];
    testDaylabel.frame =CGRectMake(self.DayShowImage.bounds.size.width*0.35,
                                   self.DayShowImage.bounds.size.width*0.30,
                                   self.DayShowImage.bounds.size.width*0.5,
                                   self.DayShowImage.bounds.size.width*0.3);
    testDaylabel.font = [UIFont systemFontOfSize:110];
    testDaylabel.textColor = [UIColor grayColor];
    testDaylabel.textAlignment = NSTextAlignmentCenter;
    testDaylabel.hidden = YES;
    [self.DayShowImage addSubview:testDaylabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)MonthStr:(NSString *)monthstr{
    int value = [monthstr intValue];
    NSString *Month = @"";
    switch (value) {
        case 1:
            Month = @"一月";
            break;
        case 2:
            Month = @"二月";
            break;
        case 3:
            Month = @"三月";
            break;
        case 4:
            Month = @"四月";
            break;
        case 5:
            Month = @"五月";
            break;
        case 6:
            Month = @"六月";
            break;
        case 7:
            Month = @"七月";
            break;
        case 8:
            Month = @"八月";
            break;
        case 9:
            Month = @"九月";
            break;
        case 10:
            Month = @"十月";
            break;
        case 11:
            Month = @"十一月";
            break;
        case 12:
            Month = @"十二月";
            break;
        default:
            break;
    }
    return Month;
}

# pragma mark -CalendarView代理方法
-(void)changeDateString:(NSString *)DateString{
    NSLog(@"传过来的值%@",DateString);
    today = [newFormatter dateFromString:DateString];
    NSString *todayString = [newFormatter stringFromDate:today];
    NSLog(@"日期是是是是%@",todayString);
        shareView.hidden = NO;
        upView.hidden = NO;
        self.DayShowImage.image = nil;
        //背景日历View
        NSString *prediate = [newFormatter stringFromDate:today];
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CalendarImage"];
        [bquery whereKey:@"date" equalTo:prediate];
        bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            BmobObject *ceshi = [array objectAtIndex:0];
            BmobFile *file = (BmobFile*)[ceshi objectForKey:@"LuPai"];
            NSURL *tempurl = (NSURL *)file.url;
            [self.DayShowImage sd_setImageWithURL:tempurl placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];
        }];
        //shareView
        BmobQuery   *bquery1 = [BmobQuery queryWithClassName:@"CalendarImage"];
        [bquery1 whereKey:@"date" equalTo:prediate];
        bquery1.cachePolicy = kBmobCachePolicyNetworkElseCache;
        [bquery1 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            BmobObject *ceshi = [array objectAtIndex:0];
            BmobFile *file = (BmobFile*)[ceshi objectForKey:@"CalendarImg"];
            NSURL *tempurl = (NSURL *)file.url;
            [originalView sd_setImageWithURL:tempurl placeholderImage:[UIImage imageNamed:@"deja-vu_2017-01-28"] options:SDWebImageRefreshCached];
            NSLog(@"url地址%@",tempurl);
        }];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.DayShowImage.alpha = 0;
            shareView.alpha = 0;
            upView.alpha = 0;
            [self.view removeGestureRecognizer:UPchangeMonthDirection];
            [self.view removeGestureRecognizer:DOWNpchangeMonthDirection];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.DayShowImage.alpha = 1;
                shareView.alpha = 1;
                upView.alpha = 1;
            } completion:^(BOOL finished) {
                [self.view addGestureRecognizer:UPchangeMonthDirection];
                [self.view addGestureRecognizer:DOWNpchangeMonthDirection];
            }];
        }];
        todaylabel.text = today.weekdayByLineWithDate;
    NSLog(@"上滑手势");

}


-(int)LaterThanToday:(NSDate *)now withOtherDate:(NSDate*)date{
    // 0可以点击  1过去 2未来
    NSDate *date423 = [newFormatter dateFromString:@"2017-04-23"];
    NSComparisonResult oldResult = [date compare:date423];
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

-(void)setLaunchImage{
    backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                             [UIScreen mainScreen].bounds.size.width,
                                                             [UIScreen mainScreen].bounds.size.height)];
    backImage.image = [UIImage imageNamed:@"dengdai_view_01.png"];
    [self.view addSubview:backImage];
    
    launchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                               [UIScreen mainScreen].bounds.size.width,
                                                               [UIScreen mainScreen].bounds.size.height)];
    launchImage.image = [UIImage imageNamed:@"dengdai_view_02.png"];
    launchImage.alpha = 0;
    [self.view addSubview:launchImage];
    
    [UIView animateWithDuration:1.0 animations:^{
        //显示第二张图片
        launchImage.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            //第二张图片消失
            launchImage.alpha = 0;
        } completion:^(BOOL finished) {
            launchImage.image = [UIImage imageNamed:@"dengdai_view_03.png"];
            [UIView animateWithDuration:2.0 animations:^{
                //显示第三张图片
                launchImage.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0 animations:^{
                    //第三张图片消失
                    launchImage.alpha = 0;
                    backImage.alpha = 0;
                } completion:^(BOOL finished) {
                    //移除launchImage
                    [launchImage removeFromSuperview];
                    [backImage removeFromSuperview];
                    [self drawMainView];

                }];
            }];
        }];
    }];
}

@end
