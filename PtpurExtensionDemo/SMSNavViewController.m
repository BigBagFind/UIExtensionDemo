//
//  SMSNavViewController.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/30.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

#import "SMSNavViewController.h"

@interface SMSNavViewController ()

@end

@implementation SMSNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];

    UILabel *titleView = [[UILabel alloc] init];
    titleView.backgroundColor = [UIColor greenColor];
    titleView.text = @"12313";
    titleView.frame = CGRectMake(0, 0, 300, 44);
    self.navigationItem.titleView = titleView;
    
   // self.tabBarItem.title = @"tabTitle";
    //self.navigationItem.title = @"33333";
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
