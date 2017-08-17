//
//  ViewController.m
//  音量震动条(复制图层)
//
//  Created by Daniel on 2017/8/16.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建复制图层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    replicatorLayer.frame = self.mainView.bounds;
    
    [self.mainView.layer addSublayer:replicatorLayer];
    
    
    CALayer *layer = [CALayer layer];
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(15, self.mainView.bounds.size.height);
    
    layer.bounds = CGRectMake(0, 0, 30, 150);
    
//    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0.1;
    anim.duration = 0.5;
    anim.repeatCount = MAXFLOAT;
    // 动画反转
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
    
    [replicatorLayer addSublayer:layer];
//    [self.mainView.layer addSublayer:layer];
    
    // 复制图层层数,包括原始层
    replicatorLayer.instanceCount = 3;
    
    // 复制图层偏移量
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    
    // 复制图层动画延迟时间
    replicatorLayer.instanceDelay = 0.1;
    
    // 复制图层背景颜色
    // 原始图层设置了颜色就不要设置此属性
    // 原始图层颜色为白色,复制图层颜色为此属性颜色
    replicatorLayer.instanceColor = [UIColor redColor].CGColor;
    
    // 复制图层颜色偏移
    replicatorLayer.instanceRedOffset = -0.3;
    
    
}


@end
