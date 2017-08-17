//
//  YCLineView.m
//  核心绘图
//
//  Created by Daniel on 2017/8/11.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "YCLineView.h"

@implementation YCLineView


- (void)drawRect:(CGRect)rect {
    
//    [self drawLine];
    
    [self juzhen];
}

- (void)juzhen
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩阵操作
    // 缩放， 旋转， 平移
    // 旋转：弧度制
    //    CGContextRotateCTM(ctx, M_PI_4);
    // 缩放： 缩放比例 大于1放大  小于1缩小
    CGContextScaleCTM(ctx, 0.5, 0.5);
    // 平移： 水平和竖直方向平移
    CGContextTranslateCTM(ctx, 100, 200);
    
    // 2. 画图
    // 画方
    CGContextAddRect(ctx, CGRectMake(200, 100, 100, 100));
    
    // 画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(20, 20, 100, 100));
    
    // 3. 渲染
    CGContextStrokePath(ctx);
    
}


- (void)drawLine
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 10, 20);
    
    CGContextAddLineToPoint(ctx, 10, 50);
    
//    CGContextStrokePath(ctx);
    
    CGContextSetLineWidth(ctx, 5);
    
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    CGContextSetRGBStrokeColor(ctx, 1.0f, 0, 0, 1);
    
    CGContextStrokePath(ctx);
    
}

@end
