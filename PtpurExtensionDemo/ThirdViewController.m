
//
//  ThirdViewController.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2017/1/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "ThirdViewController.h"
#import "FinalViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)leftAction {
    [self.navigationController pushViewController:[[FinalViewController alloc] init] animated:YES];
}

@end
