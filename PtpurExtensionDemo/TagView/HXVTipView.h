//
//  HXVTipView.h
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/30.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXVTipView : UIView


+ (instancetype)tipViewShowInView:(UIView *)superView
                       originView:(UIView *)originView
                      displayText:(NSString *)displayText;

- (void)showInView:(UIView *)superView
        originView:(UIView *)originView
       displayText:(NSString *)displayText;

- (void)dimiss;

@end
