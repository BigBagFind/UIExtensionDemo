//
//  BaseEnterpriseTableController.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/13.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "BaseEnterpriseTableController.h"
#import "MJRefresh.h"
#import "EnterpriseController.h"

@interface BaseEnterpriseTableController ()<UIScrollViewDelegate>



@end




@implementation BaseEnterpriseTableController

/*
- (NSMutableArray *)dataSource {
    if (_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
 */

- (LoadingCell *)loadingCell {
    if (!_loadingCell) {
        _loadingCell = [[[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil] lastObject];
    }
    return _loadingCell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
    
    UIView *headerView = [[UIView alloc] init];
    headerView.height = 160;
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.bounces = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.alwaysBounceHorizontal = NO;
    
}

- (void)setRefreshMethod:(SEL)refreshMethod {
    if (_refreshMethod != refreshMethod) {
        _refreshMethod = refreshMethod;
        if (_refreshMethod) {
            self.refreshControl = [[UIRefreshControl alloc] init];
            [self.refreshControl addTarget:self action:@selector(refreshMethod) forControlEvents:UIControlEventValueChanged];
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    TggLog(@"走自己：%@",self);
    if ([self.delegate respondsToSelector:@selector(tableViewDidScroll:)]) {
        [self.delegate tableViewDidScroll:scrollView];
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(tableViewDidEndDecelerating:)]) {
        [self.delegate tableViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(tableViewDidEndDragging:willDecelerate:)]) {
        [self.delegate tableViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}


#pragma mark - 填充tableView内容方法
- (void)fillContentWithRowHeight:(CGFloat)rowHeight count:(NSUInteger)count supplement:(CGFloat)supplement {
    // 先拿到内容总高度
    CGFloat totalHeight = rowHeight * count;
    // 有补充也加进来
    if (supplement > 0) {
        totalHeight += supplement;
    }
    // 大于不做处理小于则填充tableFootView
    if (totalHeight < kScreenHeight - 64 - 40) {
        UIView *footView = [UIView new];
        footView.height = kScreenHeight - 64 - 40 - totalHeight;
        footView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = footView;
    } else {
        UIView *footView = [UIView new];
        self.tableView.tableFooterView = footView;
    }

}


- (void)fetchData {
    
}




@end
