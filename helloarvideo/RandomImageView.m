//
//  RandomImageView.m
//  拾间
//
//  Created by Wll on 17/1/29.
//  Copyright © 2017年 VisionStar Information Technology (Shanghai) Co., Ltd. All rights reserved.
//

#import "RandomImageView.h"

@implementation RandomImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)awakeFromNib{
    [super awakeFromNib];
    [self initImageName];

    
}

-(void)initImageName{
    int number = 1 + (arc4random() % 7);
    NSLog(@"随机生成的数是%d",number);
    NSString *imageName =[NSString stringWithFormat:@"test-0%d.jpg",number];
    self.image = [UIImage imageNamed:imageName];
    
}

@end
