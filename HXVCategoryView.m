//
//  HXVCategoryView.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/17.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "HXVCategoryView.h"
#import "Masonry.h"


static CGFloat const HXVCategoryBarDefaultHeight = 44;

#define HXVCategoryViewDefaultTintColor         [UIColor orangeColor]
#define HXVCategoryViewDefaultSelectedColor     [UIColor redColor]

@interface HXVCategoryView () <UIScrollViewDelegate>

/**
 * categoryBarView
 */

@property (nonatomic, strong) UIScrollView *categoryBarView;

@property (nonatomic, strong) UIView *indicatorLine;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleHighlightedColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, assign) NSUInteger currentIndex;
/**
 * mainScrollView
 */

@property (nonatomic, strong) UIScrollView *mainScrollView;




@end

@implementation HXVCategoryView



#pragma mark - Public Method

- (void)reloadData {
    [self reloadCategoryView];
    [self reloadMainScrollView];
}

- (void)setCategoryTitleColor:(UIColor *_Nullable)color forState:(HXVCategoryTitleState)state {
    switch (state) {
        case HXVCategoryTitleStateNormal:
            _titleNormalColor = color;
            break;
        case HXVCategoryTitleStateSelected:
            _titleSelectedColor = color;
            break;
        case HXVCategoryTitleStateHighlighted:
            _titleHighlightedColor = color;
            break;
        default:
            _titleNormalColor = color;
            break;
    }
}

#pragma mark - Private Method

- (void)reloadCategoryView {
    _currentIndex = 0;
    for (UIView *view in _categoryBarView.subviews) {
        [view removeFromSuperview];
    }
    if (_indicatorLine) {
        _indicatorLine = nil;
    }
    NSUInteger count = [self numberOfElement];
    CGFloat itemWidth = self.frame.size.width / count;
    _categoryBarView.contentSize = CGSizeMake(self.frame.size.width, HXVCategoryBarDefaultHeight);
    for (NSUInteger idx = 0; idx < count; idx ++) {
        NSString *title = [self titleForElement:idx];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [button setTitleColor:_titleHighlightedColor forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = (CGRect){idx * itemWidth, 0, itemWidth, HXVCategoryBarDefaultHeight};
        button.titleLabel.minimumScaleFactor = 0.5;
        [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
        button.tag = 100 + idx;
        [button addTarget:self action:@selector(categoryTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_categoryBarView addSubview:button];
        if (idx == 0) {
            [button setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
        }
    }
    if (count > 0) {
        _indicatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, HXVCategoryBarDefaultHeight - 2, itemWidth, 2)];
        _indicatorLine.backgroundColor = _titleNormalColor;
        [_categoryBarView addSubview:_indicatorLine];
    }
}

- (void)reloadMainScrollView {
    for (UIView *view in _mainScrollView.subviews) {
        [view removeFromSuperview];
    }
    NSUInteger count = [self numberOfElement];
    CGFloat itemWidth = self.frame.size.width;
    CGFloat itemHeight = self.frame.size.height - HXVCategoryBarDefaultHeight;
    _mainScrollView.contentSize = CGSizeMake(itemWidth * count, itemHeight);
    for (NSUInteger idx = 0; idx < count; idx ++) {
        UIView *view = [self viewForElement:idx];
        view.frame = (CGRect){idx * itemWidth, 0, itemWidth, itemHeight};
        [_mainScrollView addSubview:view];
    }
}


- (void)categoryTitleAction:(UIButton *)sender {
    if (sender.tag == _currentIndex + 100) {
        return;
    }
    UIButton *lasted = [_categoryBarView viewWithTag:_currentIndex + 100];
    [lasted setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    [sender setTitleColor:_titleSelectedColor forState:UIControlStateNormal];
    [self setIndicatorLineContentOffsetWithIndex:sender.tag - 100];
    [_mainScrollView setContentOffset:CGPointMake((sender.tag - 100) * self.frame.size.width, 0) animated:YES];
    _currentIndex = sender.tag - 100;
}

- (void)setIndicatorLineContentOffsetWithIndex:(NSUInteger)index {
    NSUInteger count = [self numberOfElement];
    CGFloat itemWidth = self.frame.size.width / count;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = _indicatorLine.frame;
        rect.origin.x = index * itemWidth;
        _indicatorLine.frame = rect;
    } completion:nil];
}

#pragma mark - HXVDataSource

- (NSInteger)numberOfElement {
    if(_dataSource && [_dataSource respondsToSelector:@selector(numberOfElementInCategoryView:)]){
        return [_dataSource numberOfElementInCategoryView:self];
    } else {
        NSAssert(_dataSource, @"Data source is not set.");
        NSAssert([_dataSource respondsToSelector:@selector(numberOfElementInCategoryView:)], @"numberOfElementInCategoryView: not implemented.");
        return 0;
    }
}

- (NSString *)titleForElement:(NSInteger)element {
    if(_dataSource && [_dataSource respondsToSelector:@selector(categoryView:titleForElement:)]){
        return [_dataSource categoryView:self titleForElement:element];
    } else {
        NSAssert(_dataSource, @"Data source is not set.");
        NSAssert([_dataSource respondsToSelector:@selector(categoryView:titleForElement:)], @"categoryView:titleForElement:: not implemented.");
        return @"";
    }
}

- (UIView *)viewForElement:(NSInteger)element {
    if(_dataSource && [_dataSource respondsToSelector:@selector(categoryView:titleForElement:)]){
        return [_dataSource categoryView:self viewForElement:element];
    } else {
        NSAssert(_dataSource, @"Data source is not set.");
        NSAssert([_dataSource respondsToSelector:@selector(categoryView:titleForElement:)], @"categoryView:titleForElement: not implemented.");
        return [UIView new];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _mainScrollView) {
        CGRect rect = _indicatorLine.frame;
        rect.origin.x = scrollView.contentOffset.x / [self numberOfElement];
        _indicatorLine.frame = rect;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _mainScrollView) {
        NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
        UIButton *button = (UIButton *)[self viewWithTag:index + 100];
        [self categoryTitleAction:button];
    }
}

#pragma mark - LifeCycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        [self hxv_init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self hxv_init];
    }
    return self;
}

- (void)hxv_init {
    [self hxv_initViews];
    [self hxv_layoutViews];
    [self hxv_initialize];
}

- (void)hxv_initViews {
    _categoryBarView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _categoryBarView.scrollEnabled = NO;
    _categoryBarView.contentOffset = CGPointZero;
    [self addSubview:_categoryBarView];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [self addSubview:_mainScrollView];
}

- (void)hxv_layoutViews {
    [_categoryBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(HXVCategoryBarDefaultHeight);
    }];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(HXVCategoryBarDefaultHeight, 0, 0, 0));
    }];
}
    
- (void)hxv_initialize {
    _titleNormalColor = HXVCategoryViewDefaultTintColor;
    _titleHighlightedColor = nil;
    _titleSelectedColor = HXVCategoryViewDefaultSelectedColor;
    _currentIndex = 0;
}



@end
