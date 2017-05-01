//
//  SJMapViewController.m
//  拾间
//
//  Created by Wll on 17/4/12.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "SJMapViewController.h"
#import "SJLocationName.h"
@interface SJMapViewController ()<MAMapViewDelegate>{
    MAMapView *SJmapView;
    MAPointAnnotation *pointAnnotation;
}

@end

@implementation SJMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图

    [self initPointAnnotation];
    
    SJmapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    SJmapView.delegate = self;
    SJmapView.showsCompass = NO;
    SJmapView.zoomLevel = 16;
    SJmapView.showsScale = NO;
    SJmapView.showsUserLocation = YES;
    [self.view addSubview:SJmapView];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:
                            CGRectMake([UIScreen mainScreen].bounds.size.width*0.1013,
                                       [UIScreen mainScreen].bounds.size.width*0.1013,
                                       [UIScreen mainScreen].bounds.size.width*0.1067,
                                       [UIScreen mainScreen].bounds.size.width*0.1067)];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"camera_return.png"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backToHomeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    UIImageView *LabelView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.2866,
                                                             [UIScreen mainScreen].bounds.size.width*1.43,
                                                             [UIScreen mainScreen].bounds.size.width*0.4267,
                                                             [UIScreen mainScreen].bounds.size.width*0.1067)];
    LabelView.image = [UIImage imageNamed:@"ditu_img-01.png"];
    [self.view addSubview:LabelView];
}

-(void)backToHomeView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)initPointAnnotation{
    SJLocationName *name = [[SJLocationName alloc]init];
    pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation = [name BackLocationName:self.SJMapString];
    NSLog(@"%@",pointAnnotation.title);
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    [SJmapView setCenterCoordinate: CLLocationCoordinate2DMake(pointAnnotation.coordinate.latitude,
                                                               pointAnnotation.coordinate.longitude)];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SJmapView addAnnotation:pointAnnotation];
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        [annotationView setSelected:YES];
        annotationView.canShowCallout= YES;    //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;     //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
