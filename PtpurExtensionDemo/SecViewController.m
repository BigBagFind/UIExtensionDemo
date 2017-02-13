
//
//  SecViewController.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2017/1/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "SecViewController.h"
#import "ThirdViewController.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)leftAction {
    [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
}

@end
