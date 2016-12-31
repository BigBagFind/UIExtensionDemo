//
//  SMSViewController.m
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/29.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

#import "SMSViewController.h"
#import <MessageUI/MessageUI.h>
#import "AMASchemeManager.h"

@interface SMSViewController () <MFMessageComposeViewControllerDelegate>

@end

@implementation SMSViewController
- (IBAction)smsAction:(id)sender {
    [[AMASchemeManager shareManager] smsWithViewController:self];
   // [self showMessageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"navTitle";
    self.tabBarItem.title = @"..";
}

- (void)showMessageView
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:@"10086"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
       // [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
        //[[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
   // [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
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
