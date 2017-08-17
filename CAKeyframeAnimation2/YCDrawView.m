//
//  YCDrawView.m
//  核心绘图
//
//  Created by Daniel on 2017/8/16.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "YCDrawView.h"

@interface YCDrawView ()

@property (nonatomic, strong)UIBezierPath *path;

@end

@implementation YCDrawView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // touch
    UITouch *touch = [touches anyObject];
    
    // 获取手指的触摸点
    CGPoint curP = [touch locationInView:self];
    
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    
    // 设置起点
    [path moveToPoint:curP];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // touch
    UITouch *touch = [touches anyObject];
    
    // 获取手指的触摸点
    CGPoint curP = [touch locationInView:self];
    
    [self.path addLineToPoint:curP];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 给imageView添加核心动画
    // 添加核心动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    
    anim.path = self.path.CGPath;
    
    anim.duration = 5;
    
    anim.repeatCount = MAXFLOAT;
    
    [[[self.subviews firstObject] layer] addAnimation:anim forKey:nil];
}

- (void)drawRect:(CGRect)rect {
    [self.path stroke];
}


@end
