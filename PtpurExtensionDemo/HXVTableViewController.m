//
//  BaseTableViewController.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/25.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "HXVTableViewController.h"

@interface HXVTableViewController () <UIScrollViewDelegate>


@end

@implementation HXVTableViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_service reusableCellIdentifierAtIndexPath:indexPath]];
    // todo:- bindViewModels 
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [NSDate date]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_service respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [_service numberOfSectionsInTableView];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_service respondsToSelector:@selector(heightForRowAtIndexPath:)]) {
        return [_service heightForRowAtIndexPath:indexPath];
    }
    return 44;
}



#pragma mark - 
#pragma mark - Public Method

- (instancetype)initWithService:(id <HXVTableServiceProtocol>)service {
    self = [super init];
    if (self) {
        _service = service;
    }
    return self;
}


- (void)setHeaderViewYOffset:(CGFloat)offset {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, offset)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
}

- (void)fillFooterViewWithContentHeight:(CGFloat)height {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // 大于不做处理小于则填充tableFootView
    if (height < screenHeight - 64 - 40) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, screenHeight - 64 - 40 - height)];
        footView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = footView;
    } else {
        UIView *footView = [UIView new];
        self.tableView.tableFooterView = footView;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(tableViewDidScroll:)]) {
        [self.delegate tableViewDidScroll:scrollView];
    }
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


#pragma mark - Private 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.bounces = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.alwaysBounceVertical = YES;
    _tableView.alwaysBounceHorizontal = NO;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
 
    if (_service && [_service respondsToSelector:@selector(cellReuseIdentifiers)]) {
        [[_service cellReuseIdentifiers] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_tableView registerClass:NSClassFromString(obj) forCellReuseIdentifier:obj];
        }];
    }
    
}


@end
