//
//  ViewController.m
//  画板
//
//  Created by Daniel on 2017/8/14.
//  Copyright © 2017年 yctest. All rights reserved.
//

#import "ViewController.h"
#import "YCPaintView.h"

@interface ViewController ()

/**
 *  画板
 */
@property (weak, nonatomic) IBOutlet YCPaintView *paintView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clear {
    [self.paintView clear];
}

- (IBAction)back {
    [self.paintView back];
}


@end
