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

@interface HXVCategoryView ()

/**
 * categoryBarView
 */

@property (nonatomic, strong) UIScrollView *categoryBarView;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleHighlightedColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;
/**
 * mainScrollView
 */

@property (nonatomic, strong) UIScrollView *mainScrollView;




@end

@implementation HXVCategoryView



#pragma mark - Public Method

- (void)reloadData {
    [self reloadCategoryView];
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
    for (UIView *view in _categoryBarView.subviews) {
        [view removeFromSuperview];
    }
    NSUInteger count = [self numberOfElement];
    CGFloat itemWidth = self.frame.size.width / count;
    _categoryBarView.contentSize = CGSizeMake(self.frame.size.width, HXVCategoryBarDefaultHeight);
    for (NSUInteger idx = 0; idx < count; idx ++) {
        NSString *title = [self titleForElement:idx];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [button setTitleColor:_titleHighlightedColor forState:UIControlStateHighlighted];
        [button setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = (CGRect){0, idx * itemWidth, itemWidth, HXVCategoryBarDefaultHeight};
        [_categoryBarView addSubview:button];
    }
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
    [self addSubview:_categoryBarView];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _mainScrollView.pagingEnabled = YES;
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
    _titleHighlightedColor = HXVCategoryViewDefaultTintColor;
    _titleSelectedColor = HXVCategoryViewDefaultSelectedColor;
}



@end
