//
//  HoverMainViewController.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/25.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "HoverMainViewController.h"
#import "HXVTableViewController.h"

@interface HoverMainViewController () <HXVTableViewScrollDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *hoverView;


@end

@implementation HoverMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    _headerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_headerView];
    
    _hoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)];
    _hoverView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_hoverView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubControllers];
}


#pragma mark - 添加自控制器
- (void)addSubControllers {
    // 子控制器标签
    // 成长能力,盈利能力,估值
    NSArray *services = @[
                          @"HXVGrowthAbilityService",
                          @"HXVProfitAbilityService",
                          @"HXVAssessmentService"
                          ];
    for (int i = 0 ; i < services.count ;i++){
        // 设置frame
        HXVTableViewController *VC = [[HXVTableViewController alloc] initWithService:[NSClassFromString(services[i]) new]];
        VC.view.tag = 100 + i;
        VC.view.frame = (CGRect){i * self.view.frame.size.width, 0, self.view.bounds.size};
        [self addChildViewController:VC];
        [self.scrollView addSubview:VC.view];
        VC.delegate = self;
        VC.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
        // 禁止UIScrollView水平方向滚动，只允许垂直方向滚动
        VC.tableView.contentSize =  CGSizeMake(0, self.view.bounds.size.height - 64 - 40);
        
        [VC setHeaderViewYOffset:250];
        
    }
}



#pragma mark - HXVScrollDelegate
- (void)hxv_tableViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        CGRect rect = _headerView.frame;
        rect.origin.y = 0;
        _headerView.frame = rect;
    } else {
        CGRect rect = _headerView.frame;
        rect.origin.y =  MAX(-offsetY, - 200);
        _headerView.frame = rect;
        
        CGRect hoverRect = _headerView.frame;
        hoverRect.origin.y = 0;
        _hoverView.frame = rect;
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDelegate:%@",NSStringFromCGPoint(scrollView.contentOffset));
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
}

/** 滚动结束 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    
}


@end
