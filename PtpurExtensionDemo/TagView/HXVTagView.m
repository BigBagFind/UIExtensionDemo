//
//  HXVTagView.m
//  HXVTagViewDemo
//
//  Created by Wuyutie on 2017/4/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

const CGFloat   HXVTagViewDefaultNothingSelected = -1;
const CGFloat   HXVTagViewAutomaticDimension = -1;
const CGFloat   HXVTagViewDefaultItemHeight = 44;


#define HXVTagViewDefaultItemWidth   [UIScreen mainScreen].bounds.size.width / 2
#define HXVTagViewDefaultFont        [UIFont systemFontOfSize:18]


#import "HXVTagView.h"

@interface HXVTagView ()

@property (nonatomic, strong, readwrite) NSMutableArray *buttonArray;
@property (nonatomic, strong, readwrite) NSMutableArray *preparedButtonArray;

@property (nonatomic, strong, readwrite) NSMutableArray *rowHeightArray;
@property (nonatomic, strong, readwrite) NSMutableArray *rowWidthArray;
@property (nonatomic, strong, readwrite) NSMutableArray *titleArray;
@property (nonatomic, strong, readwrite) NSMutableArray *preparedTitleArray;

@end


@implementation HXVTagView


#pragma mark - Animation

- (void)rowEaseOutWithDuration:(NSTimeInterval)duration {
    [_buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        __block UIButton *new = button;
        [UIView animateWithDuration:duration animations:^{
            if ([_delegate respondsToSelector:@selector(tagView:rowDidAnimate:rowView:animationOption:)]) {
                [_delegate tagView:self rowDidAnimate:idx rowView:button animationOption:YES];
            }
        } completion:^(BOOL finished) {
            new = nil;
        }];
    }];
}

- (void)rowEaseInWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    [_preparedTitleArray removeAllObjects];
    for (NSUInteger i = 0; i < _numberOfRows; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = HXVTagViewDefaultFont;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[[self class] imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.08]] forState:UIControlStateNormal];
        button.frame = (CGRect){0, i * _rowHeight, HXVTagViewDefaultItemWidth, _rowHeight};
        [button setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:button];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 22;
        [_preparedTitleArray addObject:button];
    }
    [_preparedTitleArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if ([_delegate respondsToSelector:@selector(tagView:rowDidAnimate:rowView:animationOption:)]) {
                [_delegate tagView:self rowDidAnimate:idx rowView:button animationOption:NO];
            }
        } completion:nil];
    }];
}


#pragma mark - Public

- (void)changedDataSourceWithAnimated:(BOOL)animated {
    [self rowEaseOutWithDuration:animated ? 0.4 : 0];
    [self rowEaseInWithDuration:animated ? 0.4 : 0 delay:animated ? 0.1 : 0];
    _titleArray = _preparedTitleArray;
    [_buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([_delegate respondsToSelector:@selector(tagView:preparedTitleForRow:)]) {
            [_preparedTitleArray addObject:[_delegate tagView:self preparedTitleForRow:idx] ?: @""];
        }
    }];
}



- (void)clearData {
    [_buttonArray removeAllObjects];
    [_rowHeightArray removeAllObjects];
    [_rowWidthArray removeAllObjects];
    [_preparedTitleArray removeAllObjects];
}



- (void)reloadData {
    
}



#pragma mark - Accessor Method

- (void)setDataSource:(id<HXVTagViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self configDataSource];
        if (_delegate) {
            [self configDelegate];
        }
    }
}

- (void)setDelegate:(id<HXVTagViewDelegate>)delegate {
    _delegate = delegate;
    [self configDelegate];
}


#pragma mark - Life Cycle

- (void)configDataSource {
    [self clearData];
    if ([_dataSource respondsToSelector:@selector(numberOfRowsInTagView:)]) {
        _numberOfRows = [_dataSource numberOfRowsInTagView:self];
    }
    for (NSUInteger i = 0; i < _numberOfRows; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = HXVTagViewDefaultFont;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[[self class] imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.08]] forState:UIControlStateNormal];
        button.frame = (CGRect){0, i * _rowHeight, HXVTagViewDefaultItemWidth, _rowHeight};
        [button setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:button];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 22;
        [_buttonArray addObject:button];
    }
}

- (void)configDelegate {
    [_buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = nil;
        CGFloat width = HXVTagViewDefaultItemHeight;
        CGFloat height = _rowHeight;
        UIEdgeInsets edge = UIEdgeInsetsZero;
        if ([_delegate respondsToSelector:@selector(tagView:titleForRow:)]) {
            NSString *temp = [_delegate tagView:self titleForRow:idx];
            title = temp.length > 0 ? temp : @"";
        }
        
        if ([_delegate respondsToSelector:@selector(tagView:preparedTitleForRow:)]) {
            [_preparedTitleArray addObject:[_delegate tagView:self preparedTitleForRow:idx] ?: @""];
        }
        
        if ([_delegate respondsToSelector:@selector(tagView:heightForRow:)]) {
            CGFloat temp = [_delegate tagView:self heightForRow:idx];
            height = temp > 0 ? temp : _rowHeight;
        }
        
        if ([_delegate respondsToSelector:@selector(tagView:widthForRow:)]) {
            CGFloat temp = [_delegate tagView:self widthForRow:idx];
            if (temp == HXVTagViewAutomaticDimension) {
                if (title.length > 0) {
                    width = [title sizeWithAttributes:@{NSFontAttributeName: HXVTagViewDefaultFont}].width + 22;
                } else {
                    width = HXVTagViewDefaultItemHeight;
                }
            } else {
                width = temp > 0 ? temp : HXVTagViewDefaultItemHeight;
            }
        }
       
        if ([_delegate respondsToSelector:@selector(tagView:edgeInsetsForRow:)]) {
            edge = [_delegate tagView:self edgeInsetsForRow:idx];
        }
        
        [_titleArray addObject:title];
        [_rowHeightArray addObject:@(height)];
        [_rowWidthArray addObject:@(width)];
        
        CGFloat originY = 0;
        if (idx > 0) {
            UIButton *lastButton = _buttonArray[idx - 1];
            originY = lastButton.frame.origin.y + lastButton.frame.size.height;
        }
        
        CGFloat insetX = (HXVTagViewDefaultItemWidth * 2 - width) / 2;
        if (edge.left > 0 || edge.right > 0) {
            if (edge.left > edge.right) {
                insetX = edge.left;
            } else {
                insetX = HXVTagViewDefaultItemWidth * 2 - width - edge.right;
            }
        }
        button.frame = (CGRect){insetX, originY, width, height};
        [button setTitle:title forState:UIControlStateNormal];
    }];
}

- (void)configTagView {
    self.backgroundColor = [UIColor clearColor];
    _rowHeight = HXVTagViewDefaultItemHeight;
    _selectedRow = HXVTagViewDefaultNothingSelected;
    _minimumLineSpacing = 0;
    _numberOfRows = 0;
    _buttonArray = [@[] mutableCopy];
    _preparedTitleArray = [@[] mutableCopy];
    _titleArray = [@[] mutableCopy];
    _preparedTitleArray = [@[] mutableCopy];
    _rowHeightArray = [@[] mutableCopy];
}


#pragma mark - Init Method

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configTagView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configTagView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configTagView];
    }
    return self;
}


#pragma mark - PrivateTool

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}





@end
