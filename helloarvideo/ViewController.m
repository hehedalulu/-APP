/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    [self.glView setOrientation:[UIApplication sharedApplication].statusBarOrientation];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:
                           CGRectMake([UIScreen mainScreen].bounds.size.width*0.0725,
                                      [UIScreen mainScreen].bounds.size.width*0.0725,
                                      [UIScreen mainScreen].bounds.size.width*0.097,
                                      [UIScreen mainScreen].bounds.size.width*0.097)];
    UIImageView *cancelView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                           cancelBtn.bounds.size.width,
                                                                           cancelBtn.bounds.size.height)];
    cancelView.image = [UIImage imageNamed:@"cancelbtn"];
    [cancelBtn addSubview:cancelView];
    [cancelBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:cancelBtn];

}
-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView start];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}

@end
