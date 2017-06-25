//
//  BaseEnterpriseTableController.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/13.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "BaseTableViewController.h"
#import "EnterpriseListModel.h"
#import "LoadingCell.h"



typedef void(^TableViewDidScrollBlock)(id);


@protocol  TableViewScrollDelegate <NSObject>

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)tableViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


@end


@interface BaseEnterpriseTableController : BaseTableViewController

/** 内容偏置 */
@property (nonatomic, assign) UIEdgeInsets *contentInset;

/** tableView滑动block */
@property (nonatomic, copy) TableViewDidScrollBlock scrollBlock;

/** 自定义代理对象 */
@property (nonatomic, weak) id<TableViewScrollDelegate> delegate;

/** 数据对象 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/** loadingCell */
@property (nonatomic, strong) LoadingCell *loadingCell;

/** 是否加载过 */
@property (nonatomic, assign) BOOL isLoaded;

/** 顶部高度 */
@property (nonatomic, assign) CGFloat topHeight;


@property (nonatomic, assign) SEL refreshMethod;






/** 这个方法用来填充tableView的内容 */
- (void)fillContentWithRowHeight:(CGFloat)rowHeight count:(NSUInteger)count supplement:(CGFloat)supplement;


/** 获取数据 */
- (void)fetchData;



@end
