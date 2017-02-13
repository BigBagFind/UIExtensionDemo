//
//  AMATouchIDAuthenticationCenter.m
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/2/13.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "AMATouchIDAuthenticationCenter.h"
#import <LocalAuthentication/LocalAuthentication.h>

static AMATouchIDAuthenticationCenter *instance = nil;
@implementation AMATouchIDAuthenticationCenter


- (instancetype)defaultCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [AMATouchIDAuthenticationCenter new];
        }
    });
    return instance;
}


- (void)loadAuthenticationWithCallBack:(AMATouchIDCallBack)callBack {
 
    LAContext *myContext = [[LAContext alloc] init];
    // 这个属性是设置指纹输入失败之后的弹出框的选项
    myContext.localizedFallbackTitle = AMATouchIDFallbackTitle;
    
    NSError *authError = nil;
    NSString *myLocalizedReasonString = AMATouchIDAuthenticationReason;
    
    // MARK: 判断设备是否支持指纹识别
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
                if(success) {
                    NSLog(@"指纹认证成功");
                    if (callBack) {
                        callBack(YES, nil);
                    }
                } else {
                    NSLog(@"指纹认证失败，%@",error.description);
                    NSLog(@"%ld", (long)error.code); // 错误码 error.code
                    switch (error.code) {
                        case LAErrorAuthenticationFailed: {
                            // Authentication was not successful, because user failed to provide valid credentials
                            // -1 连续三次指纹识别错误
                            NSLog(@"授权失败");
                        }
                            break;
                        case LAErrorUserCancel: {
                            // Authentication was canceled by user (e.g. tapped Cancel button)
                            // -2 在TouchID对话框中点击了取消按钮
                            NSLog(@"用户取消验证Touch ID");
                            
                        }
                            break;
                        case LAErrorUserFallback: {
                            // Authentication was canceled, because the user tapped the fallback button (Enter Password)
                            // -3 在TouchID对话框中点击了输入密码按钮
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                NSLog(@"用户选择输入密码，切换主线程处理");
                                
                            }];
                        }
                            break;
                        case LAErrorSystemCancel: {
                            // Authentication was canceled by system (e.g. another application went to foreground)
                            // -4 TouchID对话框被系统取消，例如按下Home或者电源键
                            NSLog(@"取消授权，如其他应用切入，用户自主");
                        }
                            break;
                        case LAErrorPasscodeNotSet: {
                            // Authentication could not start, because passcode is not set on the device.
                            // -5
                            NSLog(@"设备系统未设置密码");
                        }
                            break;
                        case LAErrorTouchIDNotAvailable: {
                            // Authentication could not start, because Touch ID is not available on the device
                            // -6
                            NSLog(@"设备未设置Touch ID");
                        }
                            break;
                        case LAErrorTouchIDNotEnrolled: {
                            // Authentication could not start, because Touch ID has no enrolled fingers
                            // -7
                            NSLog(@"用户未录入指纹");
                        
                        }
                            break;
                            
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
                        case LAErrorTouchIDLockout: {
                            //Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite 用户连续多次进行Touch ID验证失败，Touch ID被锁，需要用户输入密码解锁，先Touch ID验证密码
                            // -8 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                            NSLog(@"Touch ID被锁，需要用户输入密码解锁");
                        }
                            break;
                        case LAErrorAppCancel: {
                            // Authentication was canceled by application (e.g. invalidate was called while authentication was in progress) 如突然来了电话，电话应用进入前台，APP被挂起啦");
                            // -9
                            NSLog(@"用户不能控制情况下APP被挂起");
                        }
                            break;
                        case LAErrorInvalidContext: {
                            // LAContext passed to this call has been previously invalidated.
                            // -10
                            NSLog(@"LAContext传递给这个调用之前已经失效");
                        }
                            break;
    #else
    #endif
                        default:
                        {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                NSLog(@"其他情况，切换主线程处理");
                            }];
                            break;
                        }
                    }
                }
        }];
    } else {
        NSLog(@"设备不支持指纹");
        NSLog(@"%ld", (long)authError.code);
        switch (authError.code) {
            case LAErrorTouchIDNotEnrolled: {
                NSLog(@"Authentication could not start, because Touch ID has no enrolled fingers");
                if (callBack) {
                    callBack(YES, AMAErrorTouchIDNotEnrolled);
                }
                break;
            }
            case LAErrorPasscodeNotSet: {
                NSLog(@"Authentication could not start, because passcode is not set on the device");
                if (callBack) {
                    callBack(YES, AMAErrorPasscodeNotSet);
                }
                break;
            }
            default: {
                NSLog(@"TouchID not available");
                if (callBack) {
                    callBack(YES, AMAErrorTouchIDNotAvailable);
                }
                break;
            }
        }
    }
}








@end
