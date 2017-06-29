//
//  HXVTipView.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/30.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#define HXVTipViewBackgroundColor   [UIColor whiteColor]
#define HXVTipViewTextFont          [UIFont systemFontOfSize:14]
#import "HXVTipView.h"

typedef NS_ENUM(NSInteger, HXVTriangleDirection) {
    HXVTriangleDirectionLeft,
    HXVTriangleDirectionRight,
    HXVTriangleDirectionUp,     // 尖向上
    HXVTriangleDirectionDown    // 尖向下
};

@interface HXVTriangleView : UIView

@property (nonatomic, strong, readonly) CAShapeLayer *triangleLayer;
@property (nonatomic, assign) HXVTriangleDirection triangleDirection;

- (void)reloadTriangle;

@end

@implementation HXVTriangleView

- (instancetype)init {
    self = [super init];
    if (self) {
        _triangleLayer = [CAShapeLayer layer];
        _triangleLayer.fillColor = HXVTipViewBackgroundColor.CGColor;
        _triangleLayer.lineWidth = 1.0f;                      // 线条宽度
        [self.layer addSublayer:_triangleLayer];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _triangleLayer.frame = self.bounds;
    [self _reloadTriangle];
}

- (void)reloadTriangle {
    [self setNeedsLayout];
}

- (void)_reloadTriangle {
    UIBezierPath *path = [UIBezierPath bezierPath];

    switch (_triangleDirection) {
        case HXVTriangleDirectionUp: {
            [path moveToPoint:CGPointMake(self.bounds.size.width / 2, 0)];
            [path addLineToPoint:(CGPointMake(0, self.bounds.size.height))];
            [path addLineToPoint:(CGPointMake(self.bounds.size.width, self.bounds.size.height ))];
            break;
        }
        case HXVTriangleDirectionDown: {
            [path moveToPoint:CGPointMake(self.bounds.size.width / 2, 0)];
            [path addLineToPoint:(CGPointMake(0, self.bounds.size.height))];
            [path addLineToPoint:(CGPointMake(self.bounds.size.width, self.bounds.size.height ))];

            break;
        }
        default:
            break;
    }
    _triangleLayer.path = path.CGPath;
}

@end

////////////////////////////////////////////
////////////////////////////////////////////


@interface HXVTipView ()

@property (nonatomic, strong) UIButton *backgroundButton;

@property (nonatomic, strong) HXVTriangleView *triangleView;

@property (nonatomic, strong) UIView *messageView;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, assign) BOOL tapEnabled;

@end

@implementation HXVTipView

+ (instancetype)tipViewShowInView:(UIView *)superView
               originView:(UIView *)originView
              displayText:(NSString *)displayText {
    HXVTipView *view = [[HXVTipView alloc] init];
    [view showInView:superView originView:originView displayText:displayText];
    return view;
}

- (void)showInView:(UIView *)superView
        originView:(UIView *)originView
       displayText:(NSString *)displayText {
    _messageLabel.text = displayText;
    CGRect frame = [self convertRect:originView.frame toView:self];
    CGFloat height = [self stringHeight:displayText];
   
    if (frame.origin.y >= [UIScreen mainScreen].bounds.size.height / 2) {
        _triangleView.frame = CGRectMake(frame.origin.x + frame.size.width / 2 - 8, frame.origin.y - frame.size.height - 16 - 4, 1, 1);
        _messageView.frame = CGRectMake(16, _triangleView.frame.origin.y - height, [UIScreen mainScreen].bounds.size.width - 32, 1);
    } else {
        _triangleView.triangleDirection = HXVTriangleDirectionUp;
        _triangleView.frame = CGRectMake(frame.origin.x + frame.size.width / 2 - 8, frame.origin.y + frame.size.height + 4, 1, 1);
        _messageView.frame = CGRectMake(16, _triangleView.frame.origin.y + 12, [UIScreen mainScreen].bounds.size.width - 32, 1);
    }
    _messageLabel.frame = CGRectMake(8, 8, _messageView.frame.size.width - 16, 1);
    
    [UIView animateWithDuration:0.3 animations:^{
        if (frame.origin.y >= [UIScreen mainScreen].bounds.size.height / 2) {
            _triangleView.triangleDirection = HXVTriangleDirectionDown;
            _triangleView.frame = CGRectMake(frame.origin.x + frame.size.width / 2 - 8, frame.origin.y - 12 - 4, 12, 12);
            _messageView.frame = CGRectMake(16, _triangleView.frame.origin.y - height - 16, [UIScreen mainScreen].bounds.size.width - 32, height + 16);
        } else {
            _triangleView.triangleDirection = HXVTriangleDirectionUp;
            _triangleView.frame = CGRectMake(frame.origin.x + frame.size.width / 2 - 8, frame.origin.y + frame.size.height + 4, 12, 12);
            _messageView.frame = CGRectMake(16, _triangleView.frame.origin.y + _triangleView.frame.size.height, [UIScreen mainScreen].bounds.size.width - 32, height + 16);
        }
        _messageLabel.frame = CGRectMake(8, 8, _messageView.frame.size.width - 16, height);
    } completion:^(BOOL finished) {
        _tapEnabled = YES;
    }];
    
    self.frame = [UIScreen mainScreen].bounds;
    [superView addSubview:self];
}


- (void)dimiss {
    [self removeFromSuperview];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backgroundButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _backgroundButton.frame = [UIScreen mainScreen].bounds;
    [_backgroundButton addTarget:self action:@selector(backgroundButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _backgroundButton.userInteractionEnabled = YES;
    [self addSubview:_backgroundButton];
    
    _messageView = [[UIView alloc] init];
    _messageView.layer.cornerRadius = 5;
    _messageView.layer.masksToBounds = YES;
    _messageView.backgroundColor = HXVTipViewBackgroundColor;
    [self addSubview:_messageView];
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = HXVTipViewTextFont;
    _messageLabel.numberOfLines = 0;
    [_messageView addSubview:_messageLabel];
    
    _triangleView = [[HXVTriangleView alloc] init];
    [self addSubview:_triangleView];
}

- (void)backgroundButtonClicked:(id)sender {
    if (_tapEnabled) {
        [self dimiss];
    }
}

- (CGFloat)stringHeight:(NSString *)string {
    UILabel *label = [[UILabel alloc] init];
    label.text = string.length > 0 ? string : @"哈哈";
    label.font = HXVTipViewTextFont;
    label.numberOfLines = 0;
    return [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 32 - 16, 9999)].height;
}

@end




