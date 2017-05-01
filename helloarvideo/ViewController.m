/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#import "ViewController.h"
//#import "SJMusic.h"
#import "SJMusicManager.h"

@interface ViewController (){
    UIImageView *LabelView;
//    SJMusic *music;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    self.glView.SJMusicType = 0;
    [self.glView setOrientation:[UIApplication sharedApplication].statusBarOrientation];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:
                           CGRectMake([UIScreen mainScreen].bounds.size.width*0.073,
                                      [UIScreen mainScreen].bounds.size.width*1.60,
                                      [UIScreen mainScreen].bounds.size.width*0.106,
                                      [UIScreen mainScreen].bounds.size.width*0.106)];
    [cancelBtn setBackgroundImage: [UIImage imageNamed:@"camera_return.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:cancelBtn];
    
    UIImageView *CameraLogo = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.816,
                                                                          [UIScreen mainScreen].bounds.size.width*0.04,
                                                                          [UIScreen mainScreen].bounds.size.width*0.144,
                                                                           [UIScreen mainScreen].bounds.size.width*0.144)];
    CameraLogo.image = [UIImage imageNamed:@"camera_logo.png"];
    [self.glView addSubview:CameraLogo];
    
    LabelView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.2866,
                                                            [UIScreen mainScreen].bounds.size.width*1.43,
                                                            [UIScreen mainScreen].bounds.size.width*0.4267,
                                                             [UIScreen mainScreen].bounds.size.width*0.1067)];
    LabelView.image = [UIImage imageNamed:@"camera_label.png"];
    [self.glView addSubview:LabelView];
    
//    UIButton *test = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
//    test.backgroundColor = [UIColor redColor];
//    [self.view addSubview:test];
//    [test addTarget:self action:@selector(testMp3) forControlEvents:UIControlEventTouchUpInside];
}

-(void)testMp3{
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView start];
    NSLog(@"test");
    NowMusic = @"";
    [[SJMusicManager defaultManager]playingMusic:NowMusic];
//    [[SJMusicManager defaultManager]stopMusic:NowMusic];
//    [[SJMusicManager defaultManager] disposeSound:NowMusic];
    self.glView.OpenGLDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView stop];
    [[SJMusicManager defaultManager]stopMusic:NowMusic];
    [[SJMusicManager defaultManager] disposeSound:NowMusic];
    
   
    NSLog(@"关掉音乐");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}

#pragma mark - OpenGL代理方法

-(void)changeMusicType:(NSString *)MusicName{
    if (NowMusic) {
     [[SJMusicManager defaultManager]stopMusic:NowMusic];
    }
    NSLog(@"检测到啦");
    NowMusic = MusicName;
    [[SJMusicManager defaultManager]playingMusic:MusicName];
    
    
}
@end
