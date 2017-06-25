//
//  EnterpriseSeedingListController.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "BaseEnterpriseTableController.h"


@protocol SeedingListViewControllerDelegate <NSObject>

/** 搜索按钮点击 */
- (void)seedingListSearchButtonAction:(UIButton *)sender;

/** 搜索代理回调 */
- (void)seedingListSearchBarDidBeginEditing:(UISearchBar *)searchBar;


@end


@interface EnterpriseSeedingListController : BaseEnterpriseTableController


@property (weak, nonatomic) id<SeedingListViewControllerDelegate> service;

@property (nonatomic, strong) UIView *sectionView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) EnterpriseListModel *model;




@end
