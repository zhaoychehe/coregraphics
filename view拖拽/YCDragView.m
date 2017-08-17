//
//  YCDragView.m
//  核心绘图
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "YCDragView.h"

@implementation YCDragView

// 当手指开始触摸当前的view的时候调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /** 数据集合：NSArray, NSDictionary, NSSet
     NSArray: 有序的。 一般通过角标取得里面的对象
     NSDictionary: 无序的。 键值对key-Value。通过key取得对应的Value
     NSSet:无序的。 通过 anyObject 随机取得一个值
     */
    
    // 随机取一个对象
    UITouch *touch = [touches anyObject];
    
    // 验证3个方法里面的touch是同一个对象
    NSLog(@"%s--%p--点击次数%tu", __func__, touch, touch.tapCount);
    
    // 打印所有的手指
    // View默认是不支持多点触摸, 要想让view支持多点触摸，需要自己打开
    //    NSLog(@"%d", touches.count);
    
    
}

// 当手指在当前的view上滑动的时候
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 获得手指触摸的位置
    // 获得上一次的位置
    CGPoint previousPoint = [touch previousLocationInView:self.superview];// 手指在哪一个view上面的位置
    NSLog(@"previousPoint = %@", NSStringFromCGPoint(previousPoint));
    
    // 获得当前的位置
    CGPoint currentPoint = [touch locationInView:self.superview];
    NSLog(@"currentPoint = %@", NSStringFromCGPoint(currentPoint));
    
    // 计算当前位置跟上一次位置的偏移量
    CGFloat moveX = currentPoint.x - previousPoint.x;
    CGFloat moveY = currentPoint.y - previousPoint.y;
    
    // 根据手指移动的位置，移动我们的view的位置
    // frame 跟 transform 不要同时使用
    CGPoint temp = self.center;
    temp.x += moveX;
    temp.y += moveY;
    self.center = temp;
    
    //    NSLog(@"%s--%p", __func__, touch);
    
}

// 当手指离开当前的view的时候
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    //    NSLog(@"%s--%p", __func__, touch);
}

// 当事件打断的时候调用
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
    [self touchesEnded:touches withEvent:event];
}

@end
