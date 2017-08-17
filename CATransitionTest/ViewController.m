//
//  ViewController.m
//  CATransitionTest
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, assign) int index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.backgroundColor = [UIColor yellowColor];
    
    //    UIImage *image = [UIImage imageNamed:@"me"];
    //    UIColor *myColor = [UIColor colorWithPatternImage:image];
    //    self.view.backgroundColor = myColor; // 平铺图片
    
    
    // 1. 创建图形上下文
    CGSize size = CGSizeMake(self.view.frame.size.width, 44);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 2. 画矩形， 画一根线
    // 2.1 获得当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    [[UIColor greenColor] set];
    CGContextFillPath(ctx);
    
    // 2.2  画一根线
    CGFloat lineWith = 2;
    CGFloat lineX = 0;
    CGFloat lineY = size.height - lineWith;
    CGContextMoveToPoint(ctx, lineX, lineY);
    CGContextAddLineToPoint(ctx, 320, lineY);
    CGContextSetLineWidth(ctx, lineWith);
    [[UIColor blackColor] set];
    CGContextStrokePath(ctx);
    
    // 3. 取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4. 关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 5. 使用图片来设置背景
    //    self.iconView.image = image;
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.textView.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

- (IBAction)preBtnClick {
    self.index--;
    self.textView.text = [NSString stringWithFormat:@"第%d页", self.index];
    
    
    CATransition *ca = [[CATransition alloc] init];
    ca.type = @"pageCurl";
    
//    ca.startProgress = 0.2;
//    ca.endProgress = 0.8;
    
    [self.textView.layer addAnimation:ca forKey:nil];
}

- (IBAction)nextBtnClick {
    self.index++;
    
    self.textView.text = [NSString stringWithFormat:@"第%d页", self.index];
    
    
    CATransition *ca = [[CATransition alloc] init];
    ca.type = @"pageUnCurl";
    
    [self.textView.layer addAnimation:ca forKey:nil];
    
}
@end
