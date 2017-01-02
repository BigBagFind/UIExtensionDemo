//
//  AMASchemeManager.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/29.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

#import "AMASchemeManager.h"
@import MessageUI;


@interface AMASchemeManager () <MFMessageComposeViewControllerDelegate>

@end

@implementation AMASchemeManager


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static AMASchemeManager *shareManager = nil;
    dispatch_once(&onceToken, ^{
        if(shareManager == nil) {
            shareManager = [[AMASchemeManager alloc] init];
        }
    });
    return shareManager;
}

- (void)smsWithViewController:(UIViewController *)viewcontroller {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"2"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attributes = @{[UIColor blackColor] : NSForegroundColorAttributeName};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    if( [MFMessageComposeViewController canSendText] ){
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = [NSArray arrayWithObject:@"10086"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        [viewcontroller presentViewController:controller animated:YES completion:nil];
    }else{
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }

}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"1"] forBarMetrics:UIBarMetricsDefault];
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}


@end
