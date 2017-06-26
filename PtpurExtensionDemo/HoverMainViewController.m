//
//  HoverMainViewController.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/25.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "HoverMainViewController.h"
#import "HXVTableViewController.h"

@interface HoverMainViewController () <HXVTableViewScrollDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *headerView;

@property (nonatomic, strong) UILabel *hoverView;


@end

@implementation HoverMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    _scrollView.delegate = self;
    
    _headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 200)];
    _headerView.backgroundColor = [UIColor yellowColor];
    _headerView.text = @"HeaderView";
    [self.view addSubview:_headerView];
    
    _hoverView = [[UILabel alloc] initWithFrame:CGRectMake(0, 264, self.view.bounds.size.width, 50)];
    _hoverView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_hoverView];
    _hoverView.text = @"HoverView";
    
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
        
        [VC fillFooterViewWithContentHeight:44 * 10];
    }
}



#pragma mark - HXVScrollDelegate
- (void)hxv_tableViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%lf", offsetY);
    
    CGRect rect = _headerView.frame;
    rect.origin.y = MAX(-offsetY + 64, -200 + 64);
    _headerView.frame = rect;
    
    CGFloat originY = 64;
    CGRect hoverRect = _hoverView.frame;
    if (offsetY <= 264 - 64) {
        originY = MAX(-offsetY + 264, -50 + 64);
    }
    hoverRect.origin.y = originY;
    _hoverView.frame = hoverRect;
}

- (void)hxv_tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 跟随滑动
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < _hoverView.bounds.size.height + _headerView.bounds.size.height) {
        [self updateFollowContentOffsetWithScrollView:scrollView isGreaterThanTopHeader:YES];
    } else {
        [self updateFollowContentOffsetWithScrollView:scrollView isGreaterThanTopHeader:NO];
    }
}

- (void)hxv_tableViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 跟随滑动
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < _hoverView.bounds.size.height + _headerView.bounds.size.height) {
        [self updateFollowContentOffsetWithScrollView:scrollView isGreaterThanTopHeader:YES];
    } else {
        [self updateFollowContentOffsetWithScrollView:scrollView isGreaterThanTopHeader:NO];
    }
}


- (void)updateFollowContentOffsetWithScrollView:(UIScrollView *)scrollView isGreaterThanTopHeader:(BOOL)yesOrNo {
    CGPoint offset = yesOrNo ? scrollView.contentOffset : CGPointMake(0, _hoverView.bounds.size.height + _headerView.bounds.size.height);
    NSMutableArray *ma = [@[@100, @101, @102, @103] mutableCopy];
    if ([ma containsObject:@(scrollView.tag)]) {
        [ma removeObject:@(scrollView.tag)];
    }
    for (NSNumber *tag in ma) {
        UIView *view = [_scrollView viewWithTag:[tag integerValue]];
        if ([view.subviews.firstObject isKindOfClass:[UIScrollView class]]) {
            UIScrollView *tableView1 = (UIScrollView *)view.subviews.firstObject;
            tableView1.contentOffset = offset;
        }
    }
}



@end
