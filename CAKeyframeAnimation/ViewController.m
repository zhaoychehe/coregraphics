//
//  ViewController.m
//  CAKeyframeAnimation
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)stopClick:(UIButton *)sender {
    [self.imageView.layer removeAnimationForKey:@"shake"];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 图标抖动
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    
#define AngleToRadian(angle) ((angle)/ 180.0 * M_PI)
    animation.values = @[@(AngleToRadian(-5)), @(AngleToRadian(5)), @(AngleToRadian(-5))];
    animation.duration = 0.25;
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
//    CGPoint P = CGPointMake(self.imageView.frame.origin.x + self.imageView.frame.size.width*0.5, self.imageView.frame.origin.y);
//    self.imageView.layer.anchorPoint = CGPointMake(0.5, 0);
//    self.imageView.layer.position = P;
    
    [self.imageView.layer addAnimation:animation forKey:@"shake"];
    
}


#pragma mark - 动画的代理方法
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%s", __func__);
}

- (void)test2
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    //    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 150, 150));
    //    animation.path = path;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 150, 150)];
    animation.path = path.CGPath;
    
    // 不反弹
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 2.0;
    
    animation.delegate = self;
    
    // 设置动画的节奏
    // kCAMediaTimingFunctionEaseInEaseOut 慢进 慢出
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.mainView.layer addAnimation:animation forKey:nil];
    
    //    CFRelease(path);
}


- (void)test1
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    
    animation.values = @[v1, v2, v3, v4];
    
    animation.duration = 10.0f;
    
    // 如果不控制时间的节奏， 会把duration平分（values.count - 1）份
    // 动画的节奏
    // 达到对应value值的时候对应的时间点 (0.5 * duration)，(0.75 * duration)
    animation.keyTimes = @[@(0), @(0.5),@(0.75), @(1)];
    
    // 不反弹
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.mainView.layer addAnimation:animation forKey:nil];
}

@end
