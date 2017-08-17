//
//  ViewController.m
//  CALayer-02-新建图层
//
//  Created by Daniel on 2017/8/15.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 新建图层
    //    CALayer *layer = [[CALayer alloc] init];
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 图层的position 位置属性 默认情况下 相当于UIView的center
    layer.position = CGPointMake(50, 50);
    
    // 圆角
    layer.cornerRadius = 10;
    
    // 裁剪
    layer.masksToBounds = YES;
    
    // 设置显示图片
    layer.contents = (id)[UIImage imageNamed:@"me"].CGImage;
    
    [self.view.layer addSublayer:layer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
