//
//  AMATouchIDConst.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/2/13.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "AMATouchIDConst.h"


/** 失败之后的弹出框的选项标题 */
NSString *const AMATouchIDFallbackTitle = @"忘记密码";

/** 需要TouchID的理由 */
NSString *const AMATouchIDAuthenticationReason = @"通过验证指纹进入监控页面";

/** 开启提示 */
NSString *const AMAErrorTouchIDNotEnrolled = @"请先在手机系统设置中开启TouchID功能";

/** 未设置密码 */
NSString *const AMAErrorPasscodeNotSet = @"设备系统未设置密码,请先在手机系统设置中添加密码";

/** 未知错误 */
NSString *const AMAErrorTouchIDNotAvailable = @"当前指纹设置不可用";



/*
 * 验证过程中的错误
 */

/** 通用错误标题 */
NSString *const AMAErrorTouchIDAuthFailedTitle = @"指纹认证失败";

/** 通用错误提示 */
NSString *const AMAErrorAuthenticationFailed = @"授权失败";



