//
//  HXVHitView.m
//  TabHoverViewDemo
//
//  Created by Wuyutie on 2017/7/2.
//  Copyright © 2017年 Wuyutie. All rights reserved.
//

#import "HXVHitView.h"
#import "UIView+ViewController.h"
#import "HoverMainViewController.h"


@interface HXVHitView ()

@end

@implementation HXVHitView


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    
    if (hitTestView != nil && [hitTestView isKindOfClass:[HXVHitView class]]) {
        UIViewController *viewController = hitTestView.viewController;
        if ([viewController isKindOfClass:[HoverMainViewController class]]) {
            UIScrollView *scrollView = viewController.view.subviews.firstObject;
            if ([scrollView isKindOfClass:[UIScrollView class]]) {
                // getNewTag
                UITableView *tableView = [scrollView viewWithTag:100].subviews.firstObject;
                if ([tableView isKindOfClass:[UITableView class]]) {
                    hitTestView = tableView;
                }
            }
        }
    }
    return hitTestView;
}


@end
