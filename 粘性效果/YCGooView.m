//
//  YCGooView.m
//  核心绘图
//
//  Created by Daniel on 2017/8/16.
//  Copyright © 2017年 yctest. All rights reserved.
//

// 最大圆心距离
#define kMaxDistance 80

#import "YCGooView.h"

@interface YCGooView ()

@property (nonatomic, weak) UIView *smallCircleView;

@property (nonatomic, assign)CGFloat smallRadius;

@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@end

@implementation YCGooView

- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor redColor].CGColor;
        [self.superview.layer insertSublayer:layer below:self.layer];
        _shapeLayer = layer;
    }
    return _shapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    UIView *smallCircleView = [[UIView alloc] init];
    smallCircleView.backgroundColor = [UIColor redColor];
    smallCircleView.layer.cornerRadius = self.bounds.size.width * 0.5;
    smallCircleView.bounds = self.bounds;
    smallCircleView.center = self.center;
    self.smallRadius = self.bounds.size.width * 0.5;
    [newSuperview addSubview:smallCircleView];
    self.smallCircleView = smallCircleView;
}

- (void)setup
{
    CGFloat w = self.bounds.size.width;
    self.layer.cornerRadius = w * 0.5;
    
    UIPanGestureRecognizer *gerture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:gerture];
    
}

- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint transp = [pan translationInView:self];
    
//    self.transform = CGAffineTransformTranslate(self.transform, transp.x, transp.y);
    
    CGPoint center = self.center;
    center.x += transp.x;
    center.y += transp.y;
    self.center = center;
    [pan setTranslation:CGPointZero inView:self];
    
    // 圆心距离
    CGFloat d = [self circleCenterDistanceWithBigCircleCenter:self.center smallCircleCenter:self.smallCircleView.center];
    
    // 小圆半径
    CGFloat smallRadius = self.smallRadius - d/10;
    self.smallCircleView.bounds = CGRectMake(0, 0, smallRadius*2, smallRadius*2);
    self.smallCircleView.layer.cornerRadius = smallRadius;
    
    
    // 当圆心距离大于最大圆心距离
    if (d > kMaxDistance) { // 可以拖出来
        // 隐藏小圆
        self.smallCircleView.hidden = YES;
        
        // 移除不规则的矩形
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
        
    }else if(d > 0 && self.smallCircleView.hidden == NO){ // 有圆心距离，并且圆心距离不大，才需要展示
        // 展示不规则矩形，通过不规则矩形路径生成一个图层
        self.shapeLayer.path = [self pathWithBigCirCleView:self smallCirCleView:self.smallCircleView].CGPath;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        // 当圆心距离大于最大圆心距离
        if (d > kMaxDistance) {
            // 展示gif动画
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            NSMutableArray *arrM = [NSMutableArray array];
            for (int i = 1; i < 9; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
                [arrM addObject:image];
            }
            imageView.animationImages = arrM;
            imageView.animationRepeatCount = 1;
            imageView.animationDuration = 0.5;
            [imageView startAnimating];
            [self addSubview:imageView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
            
        }else{
            
            // 移除不规则矩形
            [self.shapeLayer removeFromSuperlayer];
            self.shapeLayer = nil;
            
            // 还原位置
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                // 设置大圆中心点位置
                self.center = self.smallCircleView.center;
                
            } completion:^(BOOL finished) {
                // 显示小圆
                self.smallCircleView.hidden = NO;
            }];
            
        }
    }
}

// 计算圆心距离
- (CGFloat)circleCenterDistanceWithBigCircleCenter:(CGPoint)bigCircleCenter smallCircleCenter:(CGPoint)smallCircleCenter
{
    CGFloat offsetX = bigCircleCenter.x - smallCircleCenter.x;
    CGFloat offsetY = bigCircleCenter.y - smallCircleCenter.y;
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}

// 描述两圆之间一条矩形路径
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleView:(UIView *)smallCirCleView
{
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.width / 2;
    
    CGPoint smallCenter = smallCirCleView.center;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleView.bounds.size.width / 2;
    
    // 获取圆心距离
    CGFloat d = [self circleCenterDistanceWithBigCircleCenter:bigCenter smallCircleCenter:smallCenter];
    
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat cosθ = (y2 - y1) / d;
    
    // 坐标系基于父控件
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
    CGPoint pointP =  CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // A
    [path moveToPoint:pointA];
    // AB
    [path addLineToPoint:pointB];
    // 绘制BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    // CD
    [path addLineToPoint:pointD];
    // 绘制DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    return path;
}


@end
