//
//  ViewController.m
//  CABasicAnimation
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak)CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
//    animation.keyPath = @"transform.rotation";
//    animation.toValue = @(M_PI_2);

//    animation.keyPath = @"transform.scale";
//    animation.toValue = @(1.5);
    
//    animation.keyPath = @"transform.scale.x";
//    animation.toValue = @(1.5);
    
    animation.keyPath = @"transform.translation";
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    // 重复次数
    animation.repeatCount = MAXFLOAT;
    // 动画反转
    animation.autoreverses = YES;
    
    // 让图层保存动画执行结束时候的状态
    // 动画执行结束以后，不要移除动画
    animation.removedOnCompletion = NO;
    // 设置动画的填充模式， 保持最新的状态
    animation.fillMode = kCAFillModeForwards;
    
    // 3. 把动画添加到layer
    [self.layer addAnimation:animation forKey:nil];
}

- (void)test2
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 1, 1, 0)];
    // 让图层保存动画执行结束时候的状态
    // 动画执行结束以后，不要移除动画
    animation.removedOnCompletion = NO;
    // 设置动画的填充模式， 保持最新的状态
    animation.fillMode = kCAFillModeForwards;
    
    // 3. 把动画添加到layer
    [self.layer addAnimation:animation forKey:nil];
}


- (void)test1
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    
    // 初始值
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
//    // 改变到哪个值
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    // 改变多少值
    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    animation.duration = 2.0;
    
    // 让图层保存动画执行结束时候的状态
    // 动画执行结束以后，不要移除动画
    animation.removedOnCompletion = NO;
    // 设置动画的填充模式， 保持最新的状态
    animation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animation forKey:nil];
}

@end
