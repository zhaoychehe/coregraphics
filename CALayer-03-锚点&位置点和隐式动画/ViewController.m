//
//  ViewController.m
//  CALayer-03-锚点&位置点和隐式动画
//
//  Created by Daniel on 2017/8/15.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(50, 50);
    
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

// 点击了view以后， 执行一些动画
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    // 关闭隐式动画
//    [CATransaction begin];// 开始事务
//    [CATransaction setDisableActions:YES];
//    
//    self.layer.position = CGPointMake(251, 251);
//    //    self.layer.backgroundColor = [UIColor blueColor].CGColor;
//    
//    //    self.layer.bounds = CGRectMake(0, 0, 200, 200);
//    //    self.layer.opacity = 0.5; // 不透明度
//    
//    [CATransaction commit];// 提交事务
    
    [self test];
}

- (void)test
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(50, 50);
    
//        layer.position = CGPointZero;
    //    // 显示全
//    layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    // 位置点是相对于父图层的坐标系
    // 锚点相对于自己来说（0~1）
    // 位置点永远和锚点重合
    
    [self.view.layer addSublayer:layer];
    
}

@end
