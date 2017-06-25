//
//  BaseTableViewController.h
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/25.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXVTableServiceProtocol.h"

@protocol  HXVTableViewScrollDelegate <NSObject>

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)tableViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


@end

@protocol HXVTableServiceProtocol;
@interface HXVTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

/** 主table */
@property (nonatomic, strong, readonly) UITableView *tableView;

/** 抽象服务类 */
@property (nonatomic, strong, readonly) id<HXVTableServiceProtocol> service;

/** 自定义滑动代理对象 */
@property (nonatomic, weak) id<HXVTableViewScrollDelegate> delegate;


/** 修改头部偏移 */
- (void)setHeaderViewYOffset:(CGFloat)offset;

/** 填充footer */
- (void)fillFooterViewWithContentHeight:(CGFloat)height;


/**
 指定构造方法，禁止其他方法构造

 @param service 必须传入服务实例
 @return viewController 实例
 */
- (instancetype)initWithService:(id <HXVTableServiceProtocol>)service;




@end
