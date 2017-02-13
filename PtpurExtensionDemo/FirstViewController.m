
//
//  FirstViewController.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2017/1/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "FirstViewController.h"
#import "SecViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //左侧按钮统一设置
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeSystem];
    leftItem.frame = CGRectMake(0, 0, 30, 30);
    [leftItem setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItem];
  
}

- (void)leftAction {
    [self.navigationController pushViewController:[[SecViewController alloc] init] animated:YES];
}


@end
