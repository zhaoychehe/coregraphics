//
//  YCPaintView.m
//  核心绘图
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "YCPaintView.h"

@interface YCPaintView ()

/**
 *  保存所有的路径path
 */
@property (nonatomic, strong) NSMutableArray *totalPaths;

@end

@implementation YCPaintView

/**
 *  收集起点
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置起点
    [path moveToPoint:startPoint];
    [self.totalPaths addObject:path];
    [self setNeedsDisplay];
}

/**
 *  收集其他连线的点
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    UIBezierPath *path = [self.totalPaths lastObject];
    [path addLineToPoint:point];
    [self setNeedsDisplay];
}

/**
 * 收集到最后一个连线的点
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

// 画线
- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] set];
    for (UIBezierPath *path in self.totalPaths) {
        path.lineWidth = 5;
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        [path stroke];
    }
    
}


/**
 *  清屏
 */
- (void)clear
{
    // 清空所有的路径
    [self.totalPaths removeAllObjects];
    [self setNeedsDisplay];
}

/**
 *  回退
 */
- (void)back
{
    // 移除最后一条路径
    [self.totalPaths removeLastObject];
    [self setNeedsDisplay];
}


- (NSMutableArray *)totalPaths
{
    if (_totalPaths == nil) {
        _totalPaths = [NSMutableArray array];
    }
    return _totalPaths;
}

@end
