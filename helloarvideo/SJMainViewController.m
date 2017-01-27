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

@interface SJMainViewController ()<UIGestureRecognizerDelegate>{
    UIScreenEdgePanGestureRecognizer *leftGesture;
    UITapGestureRecognizer *tapdismiss;
    UIButton *CameraBtn;
    int imageNumber;
}
@property (strong, nonatomic) IBOutlet UIImageView *DayShowImage;
@property (weak, nonatomic) IBOutlet UIView *SJCalendarVIew;
@end

@implementation SJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //边缘手势
    self.navigationController.navigationBar.hidden = YES ;
    CameraBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.75,
                                                          [UIScreen mainScreen].bounds.size.width*0.0325,
                                                          [UIScreen mainScreen].bounds.size.width*0.18,
                                                          [UIScreen mainScreen].bounds.size.width*0.17)];
    UIImageView *CameraImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                            CameraBtn.bounds.size.width,
                                                                            CameraBtn.bounds.size.height)];
    CameraImage.image = [UIImage imageNamed:@"icon-QR.png"];
    [CameraBtn addSubview:CameraImage];
    [CameraBtn addTarget:self action:@selector(PushToARView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CameraBtn];
    
    [self setCalendarImage];
    [self addChangeMonthGesture];
    [self addedgeGesture];
    [self addlongPressSaveGesture];

}

-(void)addlongPressSaveGesture{
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    longpress.minimumPressDuration = 1.5;
    [self.view addGestureRecognizer:longpress];
    NSLog(@"添加长按手势");
}
-(void)saveImage:(UILongPressGestureRecognizer*)gesture{

    if(gesture.state==UIGestureRecognizerStateEnded){
        UIImage *tempImage = self.DayShowImage.image;
        UIImageWriteToSavedPhotosAlbum(tempImage, nil, nil, nil);//然后将该图片保存到图片
        [JCAlertView showOneButtonWithTitle:@"" Message:@"保存拾间历成功" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
    }
}

-(void)setCalendarImage{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:today];
    //NSLog(@"%@", strDate);

    if ([strDate isEqualToString:@"2017-01-28"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-01.jpg"];
        imageNumber = 1;
    }else if ([strDate isEqualToString:@"2017-01-29"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-02.jpg"];
        imageNumber = 2;
    }else if ([strDate isEqualToString:@"2017-01-30"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-03.jpg"];
        imageNumber = 3;
    }else if ([strDate isEqualToString:@"2017-01-31"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-04.jpg"];
        imageNumber = 4;
    }else if ([strDate isEqualToString:@"2017-02-01"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-05.jpg"];
        imageNumber = 5;
    }else if ([strDate isEqualToString:@"2017-02-02"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-06.jpg"];
        imageNumber = 6;
    }else if ([strDate isEqualToString:@"2017-02-03"]){
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-07.jpg"];
        imageNumber = 7;
    }else{
        self.DayShowImage.image = [UIImage imageNamed:@"calendar-01.jpg"];
        imageNumber = 1;
    }
}

-(void)PushToARView{
    [self performSegueWithIdentifier:@"PushToARView" sender:nil];
}


-(void)addedgeGesture{
    leftGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(showCalendarView)];
    leftGesture.edges = UIRectEdgeLeft;
        //[tapdismiss requireGestureRecognizerToFail:ChangeMonthDirection];
    [self.view addGestureRecognizer:leftGesture];
}

-(void)showCalendarView{
    POPSpringAnimation *showCalendarView = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    showCalendarView.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.7246,
                                                                   [UIScreen mainScreen].bounds.size.height)];
    showCalendarView.springBounciness = 1;
    showCalendarView.springSpeed = 6;
    [self.SJCalendarVIew pop_addAnimation:showCalendarView forKey:@"showCalendarView"];
    
    POPSpringAnimation *showDayImage = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    showDayImage.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.7608,
                                                               [UIScreen mainScreen].bounds.size.width*0.174,
                                                               [UIScreen mainScreen].bounds.size.width*0.9275,
                                                               [UIScreen mainScreen].bounds.size.width*1.56)];
    showDayImage.springBounciness = 1;
    showDayImage.springSpeed = 6;
    [self.DayShowImage pop_addAnimation:showDayImage forKey:@"showDayimageView"];

    
    POPSpringAnimation *showBtn = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    showBtn.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width*1.48,
                                                          [UIScreen mainScreen].bounds.size.width*0.0325,
                                                          [UIScreen mainScreen].bounds.size.width*0.18,
                                                          [UIScreen mainScreen].bounds.size.width*0.17)];
    showBtn.springBounciness = 1;
    showBtn.springSpeed = 6;
    [CameraBtn pop_addAnimation:showBtn forKey:@"showBtnView"];
    
    
    //移除滑动边缘手势
    [self.view removeGestureRecognizer:leftGesture];
    
    [self adddismissCalendarView];


}
//添加点击收回CalendarView
-(void)adddismissCalendarView{
    tapdismiss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCalendarView)];
    tapdismiss.delegate = self;
    [self.view addGestureRecognizer:tapdismiss];
    //NSLog(@"添加image手势");
    
}

-(void)dismissCalendarView{
    NSLog(@"点击image");
    //self.DayShowImage.frame = CGRectMake(15, 72, 384, 644);
    //self.SJCalendarVIew.frame = CGRectMake(-300, 0, 300, 736);
    
    POPSpringAnimation *showCalendarView = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    showCalendarView.toValue = [NSValue valueWithCGRect:CGRectMake(-[UIScreen mainScreen].bounds.size.width*0.7246,
                                                                   0,
                                                                   [UIScreen mainScreen].bounds.size.width*0.7246,
                                                                   [UIScreen mainScreen].bounds.size.height)];
    showCalendarView.springBounciness = 1;
    showCalendarView.springSpeed = 6;
    [self.SJCalendarVIew pop_addAnimation:showCalendarView forKey:@"showCalendarView2"];
    
    POPSpringAnimation *showDayImage = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    showDayImage.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.03623,
                                                               [UIScreen mainScreen].bounds.size.width*0.1739,
                                                               [UIScreen mainScreen].bounds.size.width*0.9275,
                                                               [UIScreen mainScreen].bounds.size.width*1.57)];
    showDayImage.springBounciness = 1;
    showDayImage.springSpeed = 6;
    [self.DayShowImage pop_addAnimation:showDayImage forKey:@"showDayimageView2"];
    
    
    POPSpringAnimation *showBtn = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    showBtn.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width*0.7608,
                                                          [UIScreen mainScreen].bounds.size.width*0.0325,
                                                          [UIScreen mainScreen].bounds.size.width*0.18,
                                                          [UIScreen mainScreen].bounds.size.width*0.17)];
    showBtn.springBounciness = 1;
    showBtn.springSpeed = 6;
    [CameraBtn pop_addAnimation:showBtn forKey:@"showBtnView2"];
    
    
    [self.view removeGestureRecognizer:tapdismiss];
    [self addedgeGesture];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint curP = [touch locationInView:self.view];
    NSLog(@"触摸的点%f,%f",curP.x,curP.y);
    if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        if ([touch.view isEqual:_SJCalendarVIew]) {
            NSLog(@"上下滑动日历view");
            return NO;
        }
    }
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if(curP.x < 300){
            NSLog(@"点击日历View");
            return NO;
            
        }
    }if ([gestureRecognizer isKindOfClass:[UIButton class]]) {
        return NO;
    }

    return YES;

}

//上下滑动切换月份
-(void)addChangeMonthGesture{
    UISwipeGestureRecognizer *UPchangeMonthDirection = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonth:)];
    UPchangeMonthDirection.direction = UISwipeGestureRecognizerDirectionUp;
    UPchangeMonthDirection.delegate = self;
    [self.view addGestureRecognizer:UPchangeMonthDirection];

    UISwipeGestureRecognizer *DOWNpchangeMonthDirection = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeMonth:)];
    DOWNpchangeMonthDirection.direction= UISwipeGestureRecognizerDirectionDown;
    DOWNpchangeMonthDirection.delegate = self;
    [self.view addGestureRecognizer:DOWNpchangeMonthDirection];
}

//判断上下滑动
-(void)changeMonth:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        imageNumber++;
        if (imageNumber == 8) {
            imageNumber = 7;
        }else{
            NSString *upstring = [NSString stringWithFormat:@"calendar-0%d.jpg",imageNumber];
            self.DayShowImage.image = [UIImage imageNamed:upstring];
        }
        NSLog(@"上滑手势");
    }
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {

        imageNumber--;
        if (imageNumber == 0) {
            imageNumber = 1;
        }else{
            NSString *upstring = [NSString stringWithFormat:@"calendar-0%d.jpg",imageNumber];
            self.DayShowImage.image = [UIImage imageNamed:upstring];
        }
        NSLog(@"下滑手势");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
