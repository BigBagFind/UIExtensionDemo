//
//  UIViewController+Stack.m
//  PushDemo
//
//  Created by 吴玉铁 on 2017/1/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "UIViewController+Stack.h"

@implementation UIViewController (Stack)


- (void)popToRootGestureEnable {
    if (!self.navigationController) {
        return;
    }
    if (self.navigationController.viewControllers.count < 2) {
        return;
    }
    if (!self.navigationController.viewControllers.firstObject || !self.navigationController.viewControllers.lastObject) {
        return;
    }
    NSArray *newViewControllers = @[self.navigationController.viewControllers.firstObject,self.navigationController.viewControllers.lastObject];
    self.navigationController.viewControllers = newViewControllers;
}


@end
