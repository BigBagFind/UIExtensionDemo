//
//  EnterpriseController.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "EnterpriseController.h"
#import "EnterpriseDetailBar.h"
#import "BaseEnterpriseTableController.h"
#import "EnterpriseSeedingListController.h"
#import "EnterpriseCaseController.h"
#import "EnterpriseIntrodutionController.h"
#import "TggTagView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

static NSString *const identifier = @"enterpriseDetailCell";

// 放大倍数
static CGFloat const zoomScale = 1.1;
// 内置标签栏数量
static NSUInteger const tabCount = 3;


@interface EnterpriseController ()<TableViewScrollDelegate,SeedingListViewControllerDelegate,UIScrollViewDelegate> {
    
    EnterpriseDetailBar *_navBar;
    
    NSUInteger _selectTag;
    
    CGFloat  _topHeight;
    
}


/** 毛玻璃背景 */
@property (weak, nonatomic) IBOutlet UIImageView *blurredView;

/** 中间的悬停View */
@property (weak, nonatomic) IBOutlet UIView *hoverView;

/** 悬停上面的View */
@property (weak, nonatomic) IBOutlet UIView *topView;

/** 真正装内容的scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;

/** 标签视图 */
@property (nonatomic, strong) TggTagView *tagView;

/** hoverView的top约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hoverTopConstraint;

/** topView的Height约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

/** topView的top约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;

/** 企业信息 */
@property (weak, nonatomic) IBOutlet UIImageView *entIcon;

@property (weak, nonatomic) IBOutlet UILabel *entName;

@property (weak, nonatomic) IBOutlet UILabel *entAddress;

@property (weak, nonatomic) IBOutlet UILabel *entContact;

@property (weak, nonatomic) IBOutlet UILabel *entPhone;



@end


@implementation EnterpriseController



#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topHeight = 120;
    _selectTag = 300;
    
    [self configureBlurredView];
    [self configureTabView];
    [self configureTopView];
    [self addSubControllers];
    
    _navBar = (EnterpriseDetailBar *)self.navigationController.navigationBar;
    _navBar.titleLabel.text = @"铁拳科技有限公司";
    _navBar.titleLabel.alpha = 0.0;

    self.automaticallyAdjustsScrollViewInsets = NO;

    // 初始化滑动开关
    _detailScrollView.bounces = YES;
    _detailScrollView.alwaysBounceVertical = NO;
    _detailScrollView.alwaysBounceHorizontal = YES;
    _detailScrollView.showsVerticalScrollIndicator = NO;
    _detailScrollView.showsHorizontalScrollIndicator = NO;
 
    self.currentOffset = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    TggApplication.statusBarStyle = 1;
}

/** override */
- (void)configNav {
    
}

/** CustomNavBar */
- (Class)rt_navigationBarClass {
    return [EnterpriseDetailBar class];
}

/** LeftItem */
- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"left_arrow_white"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/** 初始化毛玻璃背景 */
- (void)configureBlurredView {
    [self.blurredView setImageToBlur:[UIImage imageNamed:@"Default-568h@2x"] completionBlock:nil];
}

/** 初始化标签栏 */
- (void)configureTabView {
    // 标签栏数据
    NSArray *titles = @[@"苗木供应",@"企业介绍",@"典型案例"];
    CGFloat itemWidth = TggScreenWidth / titles.count;
    // 禁止UIScrollView垂直方向滚动，只允许水平方向滚动
    self.detailScrollView.contentSize = CGSizeMake(kScreenWidth * titles.count, 0);
    // 标签栏按钮
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        [self.hoverView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hoverView.mas_top);
            make.left.equalTo(self.hoverView.mas_left).with.offset(i * itemWidth);
            make.bottom.equalTo(self.hoverView.mas_bottom);
            make.width.mas_equalTo(itemWidth);
        }];
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:TggRGBColor(85, 85, 85) forState:UIControlStateNormal];
        button.titleLabel.font = TggFont(14);
        [button addTarget:self action:@selector(selectedTabAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 300 + i;
        
        if (i == 0) {
            [button setTitleColor:TggNavBarColor forState:UIControlStateNormal];
            button.transform = CGAffineTransformScale(button.titleLabel.transform, zoomScale, zoomScale);
        }
    }
}

/** 初始化TopView */
- (void)configureTopView {
    // tagViewInit
    self.tagView = [TggTagView new];
    // 初始化给个高度
    self.tagView.frame = CGRectMake(102, 83, kScreenWidth - 8 - 102, 30);
    [self.topView addSubview:self.tagView];
    self.tagView.backgroundColor = [UIColor clearColor];
    // 更新企业信息
    [self.entIcon sd_setImageWithURL:[NSURL URLWithString:self.model.URL] placeholderImage:[TggEasyTool tggAlterToImageWithColor:TggRGBColor(244, 244, 244)] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
           [self.blurredView setImageToBlur:image completionBlock:nil];
        }
    }];
    self.entName.text = self.model.COM_NAME;
    self.entAddress.text = self.model.ADDRESS;
    self.entContact.text = self.model.NAME;
    self.entPhone.text = self.model.MOB;
    // 数据进来后刷新高度
    self.tagView.tagArray = self.model.tagList;
    [self.tagView reloadData];
    @weakify(self);
    self.tagView.layout.CompleteBlock = ^(CGFloat height) {
        TggLog(@"height ：%lf",height);
        @strongify(self);
        // 保存本次的topHeight
        _topHeight = 83 + height;
        // 重设topViewHeight
        self.topViewHeight.constant = self->_topHeight;
        // 重刷headerView
        for (NSUInteger i = 100; i  < 103; i ++) {
            UITableView *currentTable = [self.detailScrollView viewWithTag:i];
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _topHeight + 40)];
            headerView.backgroundColor = [UIColor clearColor];
            currentTable.tableHeaderView = headerView;
            // 冲刷seedingList
            BaseEnterpriseTableController *VC = (BaseEnterpriseTableController *)self.childViewControllers[i - 100];
            VC.topHeight = self->_topHeight;
        }
        // 重设约束
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView.mas_left).offset(102);
            make.right.equalTo(self.topView.mas_right).offset(-8);
            make.bottom.equalTo(self.topView.mas_bottom);
            make.height.mas_equalTo(height);
        }];
        [self.tagView setNeedsLayout];
    };
    
}


#pragma mark - 标签栏按钮点击事件
- (void)selectedTabAction:(UIButton *)button {
    if (button.tag == _selectTag) {
        return ;
    }
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        //先取消上一次的颜色
        UIButton *previousButton = (UIButton *)[self.hoverView viewWithTag:_selectTag];
        [previousButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        previousButton.transform = CGAffineTransformIdentity;
        //设置选中选项
        [button setTitleColor:TggNavBarColor forState:UIControlStateNormal];
        button.transform = CGAffineTransformScale(previousButton.transform, zoomScale, zoomScale);
        //移动滑动视图
        [self.detailScrollView setContentOffset:CGPointMake((button.tag - 300) * kScreenWidth, 0)];
        [self scrollViewDidEndDecelerating:self.detailScrollView];
    }];
    _selectTag = button.tag;
}

#pragma mark - 添加自控制器
- (void)addSubControllers {
    // 子控制器标签
    NSArray *idetifiers = @[
                            @"EnterpriseSeedingListController",
                            @"EnterpriseIntrodutionController",
                            @"EnterpriseCaseController"
                            ];
    for (int i = 0 ; i < idetifiers.count ;i++){
        // 设置frame
        BaseEnterpriseTableController *VC = [[UIStoryboard storyboardWithName:@"Enterprise" bundle:nil] instantiateViewControllerWithIdentifier:idetifiers[i]];
        if (i == 0) {
            EnterpriseSeedingListController *seedingVC = (EnterpriseSeedingListController *)VC;
            seedingVC.service = self;
            seedingVC.model = self.model;
        } else if (i == 2) {
            EnterpriseCaseController *caseVC = (EnterpriseCaseController *)VC;
            caseVC.model = self.model;
        } else {
            EnterpriseIntrodutionController *introductionVc = (EnterpriseIntrodutionController *)VC;
            introductionVc.model = self.model;
        }
        VC.topHeight = _topHeight;
        VC.view.tag = 100 + i;
        VC.view.frame = self.detailScrollView.bounds;
        VC.view.left = i * kScreenWidth;
        [self addChildViewController:VC];
        [self.detailScrollView addSubview:VC.view];
        VC.delegate = self;
       // 禁止UIScrollView水平方向滚动，只允许垂直方向滚动
        VC.tableView.contentSize =  CGSizeMake(0, kScreenHeight - 64 - 40);
        
    }
}

#pragma mark - 回调的TableScrollViewDelegate
- (void)tableViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    self.currentOffset = offsetY;
    TggLog(@"currentOffset：%lf",self.currentOffset);
    // topView偏移量为topHeight - 40
    self.topView.alpha = 1 - offsetY / (_topHeight - 40);
    if (offsetY > 64) {
        // navBarTitle偏移量为96 - 40
        _navBar.titleLabel.alpha = (offsetY - 40) / 64;
    } else {
        _navBar.titleLabel.alpha = 0;
    }
    if (offsetY <= 0) {
        self.topViewTop.constant = 0;
        // hoverView跟着bounce
        self.hoverTopConstraint.constant = -offsetY;
    } else {
        // 还原hoverViewTop
        self.hoverTopConstraint.constant = 0;
        // topView顶部位置，设个最大值
        self.topViewTop.constant = MAX(-offsetY, -_topHeight);
    }
    TggLog(@"offset:%lf",offsetY);
    [self.view layoutIfNeeded];
}

- (void)tableViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    // 跟随滑动
    if (offsetY < _topHeight) {
        TggLog(@"y40:%lf",offsetY);
        [self setFollowContentOffsetWithScrollView:scrollView type:1];
    } else {
        TggLog(@"more40:%lf",offsetY);
        [self setFollowContentOffsetWithScrollView:scrollView type:2];
    }
    [self.view layoutIfNeeded];
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    // 跟随滑动
    if (offsetY < _topHeight) {
        TggLog(@"y40:%lf",offsetY);
        [self setFollowContentOffsetWithScrollView:scrollView type:1];
    } else {
        TggLog(@"more40:%lf",offsetY);
        [self setFollowContentOffsetWithScrollView:scrollView type:2];
    }
    [self.view layoutIfNeeded];
}

- (void)setFollowContentOffsetWithScrollView:(UIScrollView *)scrollView type:(NSUInteger)type {
    CGPoint offset = type == 1 ? scrollView.contentOffset : CGPointMake(0, _topHeight);
    if (scrollView.tag == 100) {
        UITableView *tableView1 = [self.detailScrollView viewWithTag:101];
        tableView1.contentOffset = offset;
        UITableView *tableView2 = [self.detailScrollView viewWithTag:102];
        tableView2.contentOffset = offset;
    } else if (scrollView.tag == 101) {
        UITableView *tableView1 = [self.detailScrollView viewWithTag:100];
        tableView1.contentOffset = offset;
        UITableView *tableView2 = [self.detailScrollView viewWithTag:102];
        tableView2.contentOffset = offset;
    } else if (scrollView.tag == 102) {
        UITableView *tableView1 = [self.detailScrollView viewWithTag:100];
        tableView1.contentOffset = offset;
        UITableView *tableView2 = [self.detailScrollView viewWithTag:101];
        tableView2.contentOffset = offset;
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    TggLog(@"scrollViewDelegate:%@",NSStringFromCGPoint(scrollView.contentOffset));
    // 最终颜色TggRGBColor(36, 171, 27)   tggRGBColor(85, 85, 85)
    CGFloat value = scrollView.contentOffset.x / TggScreenWidth;
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    // 即将滑向的目标缩放值
    CGFloat scaleRight = value - leftIndex;
    // 远离的目标缩放值
    CGFloat scaleLeft = 1 - scaleRight;
    // RGB偏差
    NSUInteger ROffset = 85 - 36;
    NSUInteger GOffset = 171 - 85;
    NSUInteger BOffset = 85 - 27;
    // 如果右边已经没有板块了 且左边到底不能移动
    if (rightIndex < tabCount && value > 0) {
        // 远去的变化
        UIButton *leftButton = (UIButton *)[self.hoverView viewWithTag:leftIndex + 300];
        [leftButton setTitleColor:TggRGBColor(85 - ROffset * scaleLeft, 85 + GOffset * scaleLeft, 85 - 27 * scaleLeft) forState:UIControlStateNormal];
        leftButton.transform = CGAffineTransformMakeScale(1.0 + 0.1 * scaleLeft, 1.0 + 0.1 * scaleLeft);
        // 新来的变化
        UIButton *currentButton = (UIButton *)[self.hoverView viewWithTag:rightIndex + 300];
        [currentButton setTitleColor:TggRGBColor(36 + ROffset * scaleLeft, 171 - GOffset * scaleLeft, 27 + BOffset * scaleLeft) forState:UIControlStateNormal];
        currentButton.transform = CGAffineTransformMakeScale(1.0 + 0.1 * scaleRight, 1.0 + 0.1 * scaleRight);
    }
    // 关闭searbar点击
    EnterpriseSeedingListController *listVc = [self.childViewControllers firstObject];
    listVc.searchBar.userInteractionEnabled = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // resignKeyboard
    [self.view endEditing:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 打开searbar点击
    EnterpriseSeedingListController *listVc = [self.childViewControllers firstObject];
    listVc.searchBar.userInteractionEnabled = YES;
    
}

/** 滚动结束 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / kScreenWidth;
    // 记录上方按钮tag
    _selectTag = index + 300;
    // 打开searbar点击
    EnterpriseSeedingListController *listVc = [self.childViewControllers firstObject];
    listVc.searchBar.userInteractionEnabled = YES;
    // 加载数据
    TggLog(@"currentIndex:%zd",index);
    BaseEnterpriseTableController *baseVc = self.childViewControllers[index];
    [baseVc fetchData];
    
}

#pragma mark - FirstSeedingListVCService
- (void)seedingListSearchButtonAction:(UIButton *)sender {
    TggLog(@"searching");
 
}

- (void)seedingListSearchBarDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        UITableView *currentTable = [self.detailScrollView viewWithTag:100];
        [currentTable setContentOffset:CGPointMake(0, _topHeight)];
        UITableView *table1 = [self.detailScrollView viewWithTag:101];
        [table1 setContentOffset:CGPointMake(0, _topHeight)];
        UITableView *table2 = [self.detailScrollView viewWithTag:102];
        [table2 setContentOffset:CGPointMake(0, _topHeight)];
    }];
}







@end
