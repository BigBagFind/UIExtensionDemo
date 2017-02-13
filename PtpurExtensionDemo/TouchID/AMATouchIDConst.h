//
//  AMATouchIDConst.h
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/2/13.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 成功与否，回调回去原因 */
typedef void(^AMATouchIDCallBack)(BOOL success, NSString *interpretation);

/** 失败之后的弹出框的选项标题 */
extern NSString *const AMATouchIDFallbackTitle;

/** 需要TouchID的理由 */
extern NSString *const AMATouchIDAuthenticationReason;

/** 开启提示 */
extern NSString *const AMAErrorTouchIDNotEnrolled;

/** 未设置密码 */
NSString *const AMAErrorPasscodeNotSet;

/** 位置错误 */
NSString *const AMAErrorTouchIDNotAvailable;

