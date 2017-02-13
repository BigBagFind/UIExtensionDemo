
//
//  RootViewController.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2017/1/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)action:(id)sender {
    [self.navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
}


@end
