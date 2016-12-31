//
//  AMASchemeManager.h
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/29.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface AMASchemeManager : NSObject


+ (instancetype)shareManager;
- (void)smsWithViewController:(UIViewController *)viewcontroller;

@end
