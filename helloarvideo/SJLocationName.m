//
//  SJLocationName.m
//  拾间
//
//  Created by Wll on 17/4/12.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "SJLocationName.h"

@implementation SJLocationName

-(MAPointAnnotation *)BackLocationName:(NSString*)DateString{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    if ([DateString isEqualToString:@"2017-04-23"]) {
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.551916, 114.30964);
        pointAnnotation.title = @"仁济医院";
        pointAnnotation.subtitle = @"武汉市武昌区粮道街办事处昙华林与胭脂路交叉口东南50米仁济医院";
    }else if ([DateString isEqualToString:@"2017-04-24"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552199,114.30882);
        pointAnnotation.title = @"武昌花园山牧师公寓";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林与胭脂路交叉口西100米武昌花园山牧师公寓";
    }else if ([DateString isEqualToString:@"2017-04-25"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552442,114.308385);
        pointAnnotation.title = @"翁守谦故居";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林62号翁守谦故居";
    }else if ([DateString isEqualToString:@"2017-04-26"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552957,114.306662);
        pointAnnotation.title = @"昙华林小学";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林9号武昌区昙华林小学(西南门)";
    }else if ([DateString isEqualToString:@"2017-04-27"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552893,114.306188);
        pointAnnotation.title = @"基督教崇真堂";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林2号武汉市基督教崇真堂(东北门)";
    }else if ([DateString isEqualToString:@"2017-04-28"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552251,114.306414);
        pointAnnotation.title = @"汪泽旧宅";
        pointAnnotation.subtitle = @"汪泽旧宅";
    }else if ([DateString isEqualToString:@"2017-04-29"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.55172,114.308697);
        pointAnnotation.title = @"嘉诺撒小教堂";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道郭家营小区";
    }else if ([DateString isEqualToString:@"2017-04-30"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552115,114.308775);
        pointAnnotation.title = @"主教公署";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街昙华林特1号";
    }else if ([DateString isEqualToString:@"2017-05-01"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550998,114.307969);
        pointAnnotation.title = @"花园山天主堂";
        pointAnnotation.subtitle = @"武汉市武昌区粮道街办事处胭脂路花园山天主教堂";
    }else if ([DateString isEqualToString:@"2017-05-02"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552541,114.308799);
        pointAnnotation.title = @"古天文台遗址";
        pointAnnotation.subtitle = @"古天文台遗址";
    }else if ([DateString isEqualToString:@"2017-05-03"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550651,114.311692);
        pointAnnotation.title = @"文华大学文学院";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林湖北中医药大学的8号楼文华大学文学院";
    }else if ([DateString isEqualToString:@"2017-05-04"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550368,114.312918);
        pointAnnotation.title = @"文华大学礼拜堂";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林188号文华大学礼拜堂";
    }else if ([DateString isEqualToString:@"2017-05-05"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550118,114.312961);
        pointAnnotation.title = @"文华大学神学院";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道涵三宫小区湖北中医药大学(昙华林校区)";
    }else if ([DateString isEqualToString:@"2017-05-06"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550482,114.314721);
        pointAnnotation.title = @"文华书院翟雅阁";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道昙华林189号湖北中医药大学(昙华林校区)";
    }else if ([DateString isEqualToString:@"2017-05-07"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550736,114.305599);
        pointAnnotation.title = @"日知会";
        pointAnnotation.subtitle = @"日知会";
    }else if ([DateString isEqualToString:@"2017-05-08"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552364,114.309137);
        pointAnnotation.title = @"瑞典教区";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道凤凰山小区";
    }else if ([DateString isEqualToString:@"2017-05-09"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.551916,114.306304);
        pointAnnotation.title = @"石瑛公馆";
        pointAnnotation.subtitle = @"武汉市武昌区昙华林三义村特1号石瑛旧居";
    }else if ([DateString isEqualToString:@"2017-05-10"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550542, 114.312323);
        pointAnnotation.title = @"文华书院理学院";
        pointAnnotation.subtitle = @"武汉市武昌区粮道街办事处昙华林与胭脂路交叉口东南50米仁济医院";
    }else if ([DateString isEqualToString:@"2017-05-11"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.54807, 114.315531);
        pointAnnotation.title = @"榆园";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道云架桥小区湖北美术学院(昙华林校区)";
    }else if ([DateString isEqualToString:@"2017-05-12"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.548447, 114.315619);
        pointAnnotation.title = @"朴园";
        pointAnnotation.subtitle = @"武汉市武昌区中山路374号湖北美术学院内钱基博故居";
    }else if ([DateString isEqualToString:@"2017-05-13"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.549135, 114.314134);
        pointAnnotation.title = @"文华学院教室宿舍";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道马家巷湖北中医药大学(昙华林校区)";
    }else if ([DateString isEqualToString:@"2017-05-14"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550846, 114.311113);
        pointAnnotation.title = @"文华公书林";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道粮道街花园山社区湖北中医药大学(昙华林校区)";
    }else if ([DateString isEqualToString:@"2017-05-15"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.550403, 114.305945);
        pointAnnotation.title = @"晏道刚故居";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道后补街小区戈甲营社区";
    }else if ([DateString isEqualToString:@"2017-05-16"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.551882, 114.309942);
        pointAnnotation.title = @"孙茂森花园";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道粮道街花园山社区";
    }else if ([DateString isEqualToString:@"2017-05-17"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.548045, 114.312091);
        pointAnnotation.title = @"武汉中学校旧址";
        pointAnnotation.subtitle = @"武汉市武昌区粮道街特1号附近私立武汉中学校旧址纪念馆(东北门)";
    }else if ([DateString isEqualToString:@"2017-05-18"]){
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.552592, 114.30731);
        pointAnnotation.title = @"刘公公馆";
        pointAnnotation.subtitle = @"湖北省武汉市武昌区粮道街街道郭家营小区";
    }else{
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.553093, 114.305646);
        pointAnnotation.title = @"拾间书局";
        pointAnnotation.subtitle = @"拾间书局";
    }
    
    return pointAnnotation;
}

@end
