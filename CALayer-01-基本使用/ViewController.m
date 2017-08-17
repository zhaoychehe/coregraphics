//
//  ViewController.m
//  CALayer-01-基本使用
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 赋值结构体直接改变CATransform3D属性
    //    self.iconView.transform = CGAffineTransformMakeRotation(M_PI_4);
    //    self.iconView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0);
    //    self.iconView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
    
    
    // 2. KVC改变transform属性
    //    NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 1, 1, 0)];
    //    [self.iconView.layer setValue:value forKeyPath:@"transform"];
    
    [self.iconView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation"];
    
    //    self.iconView.layer.transform = CATransform3DMakeScale(0.5, 1, 1.5);
    
    //    [self.iconView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 1, 1.5)] forKeyPath:@"transform"];
    //
    //    [self.iconView.layer setValue:@(0.5) forKeyPath:@"transform.scale.x"];
    
    //    [self.iconView.layer setValue:@(-100) forKeyPath:@"transform.translation.x"];
    
    // 使用KVC的注意点：
    //    1> 给对象的哪个属性赋值，就写到keyPath里面。
    //    2> value的值一定是属性的类型才行
    
    
//    [self test1];
//    [self test2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.iconView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    [self.iconView setNeedsDisplay];
}


- (void)test2
{
    // 圆角
    self.iconView.layer.cornerRadius = 10;
    //    // 超出主层的部分减掉
    //    self.iconView.layer.masksToBounds = YES;
    
    // 边框的宽度
    self.iconView.layer.borderWidth = 10;
    
    // 边框的颜色
    self.iconView.layer.borderColor = [UIColor greenColor].CGColor;
    
    // 阴影的颜色
    self.iconView.layer.shadowColor = [UIColor yellowColor].CGColor;
    
    // 阴影偏差
    self.iconView.layer.shadowOffset = CGSizeMake(20, 20);
    
    // 不透明度
    self.iconView.layer.shadowOpacity = 0.5;
    
    // imageView要想显示阴影， 不能进行裁剪主层以外的部分
}

- (void)test1
{
    // 边框的宽度
    self.greenView.layer.borderWidth = 5;
    // 边框的颜色
    self.greenView.layer.borderColor = [UIColor yellowColor].CGColor;
    // 边框的圆角
    self.greenView.layer.cornerRadius = 125;
    
    // 阴影的颜色
    self.greenView.layer.shadowColor = [UIColor grayColor].CGColor;
    
    // 阴影的偏差, 必须有偏差
    self.greenView.layer.shadowOffset = CGSizeMake(20, 20);
    
    // 阴影的不透明度
    self.greenView.layer.shadowOpacity = 0.5;
}


@end
