//
//  EnterpriseSeedingListController.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "EnterpriseSeedingListController.h"
#import "EnterpriseSeedingCell.h"
#import "EnterpriseController.h"
#import "EntSeedingModel.h"

static NSString *identifier = @"EnterpriseSeedingCell";


@interface EnterpriseSeedingListController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *filterArray;


@end


@implementation EnterpriseSeedingListController


- (void)setModel:(EnterpriseListModel *)model {
    if (_model != model) {
        _model = model;
        if (model) {
            [self fetchData];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createSectionHeaderView];

    @weakify(self);
    [self.loadingCell reloadHandle:^{
        @strongify(self);
        [self fetchData];
    }];
}

- (void)createSectionHeaderView {
    
    self.sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.sectionView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.sectionView addSubview:self.searchBar];
    self.searchBar.tintColor = TggNavBarColor;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入苗木名称";
    // 改变searbar的clearMode
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 1) {
            if ( [[view.subviews objectAtIndex:1] isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)[view.subviews objectAtIndex:1];
                [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
            }
            break;
        }
    }
    self.tableView.sectionHeaderHeight = 44;
    
}


#pragma mark - 点击开始搜搜
- (void)searchButtonAction:(UIButton *)sender {
    [self.service seedingListSearchButtonAction:sender];
}

#pragma mark - UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isLoaded) {
        return self.dataSource.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLoaded) {
        EnterpriseSeedingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.model = self.dataSource[indexPath.row];
        return cell;
    } else {
        return self.loadingCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLoaded) {
        return 86;
    } else {
        return kScreenHeight - 64 - 40;
    }
}


#pragma mark - UISearBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.service seedingListSearchBarDidBeginEditing:searchBar];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SEDDLING_TYPE contains [cd] %@", searchText];
        if (self.dataSource != nil) {
            [self.dataSource removeAllObjects];
        }
        self.dataSource = [[NSMutableArray alloc] initWithArray:[self.filterArray filteredArrayUsingPredicate:predicate]];
    } else {
        [self.dataSource removeAllObjects];
        self.dataSource = [[NSMutableArray alloc] initWithArray:self.filterArray];
    }
    
    [self fillContentWithRowHeight:86 count:self.dataSource.count supplement:44];
    [self.tableView reloadData];
    TggLog(@"%lf",self.topHeight);
    [self.tableView setContentOffset:CGPointMake(0, self.topHeight)];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    TggDISPATCH_ON_MAIN_THREAD(^{
        [searchBar resignFirstResponder];
    });
}

#pragma mark - 正常主页刷新请求数据
- (void)fetchData {
    if (self.isLoaded == YES) {
        return ;
    }
    
    self.searchBar.userInteractionEnabled = NO;
    
    NSDictionary *params = @{
                             @"MOB" : self.model.MOB
                            };
    TggLog(@"%@",params);
    [TggDataService TggAFrequestUrlString:EnterpriseSeedingList HTTPMethod:@"POST" params:[params mutableCopy] progressHandle:^(NSProgress *progress) {
        
    } completionHandle:^(id result) {
        TggLog(@"fetchEnterpriseIntroduction:\n%@",result);
        if (TggNetSucceed) {
            // 转换模型
            self.dataSource = [NSMutableArray arrayWithArray:[EntSeedingModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"GYlist"]]];
            // 构造过滤数组
            self.filterArray = [NSMutableArray arrayWithArray:self.dataSource];
            // 更新状态
            self.isLoaded = YES;
            // 统配高度
            [self fillContentWithRowHeight:86 count:self.dataSource.count supplement:44];
            // 刷新数组
            [self.tableView reloadData];
            // 结束刷新
            [self.loadingCell endLoading];
            
            self.searchBar.userInteractionEnabled = YES;
        } else {
            [self.loadingCell failedLoading];
            [self tgg_showAutoWarning:TggNetMsg];
        }
    } errorHandle:^(NSError *error) {
        
        // 转换模型
        self.dataSource = [NSMutableArray array];
        for (NSUInteger i = 0; i < 10; i++) {
            [self.dataSource addObject:[[EntSeedingModel alloc] init]];
        }
        
        // 构造过滤数组
        self.filterArray = [NSMutableArray arrayWithArray:self.dataSource];
        // 更新状态
        self.isLoaded = YES;
        // 统配高度
        [self fillContentWithRowHeight:86 count:self.dataSource.count supplement:44];
        // 刷新数组
        [self.tableView reloadData];
        // 结束刷新
        [self.loadingCell endLoading];
        
        self.searchBar.userInteractionEnabled = YES;
        
//        TggLog(@"fetchEnterpriseIntroduction:\n%@",error.userInfo);
//        [self.loadingCell failedLoading];
//        [self tgg_showAndHandleError:error];
    }];
    
}







@end
