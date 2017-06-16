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
#import "FirstViewController.h"
#import "HXVTagView.h"
#import "HXVCategoryView.h"

@interface SMSViewController () <MFMessageComposeViewControllerDelegate, HXVTagViewDelegate, HXVTagViewDataSource, UITextViewDelegate, HXVCategoryViewDelegate , HXVCategoryViewDataSource>

@property (nonatomic, strong) HXVTagView *tagView;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) HXVCategoryView *categoryView;

@end

@implementation SMSViewController


- (IBAction)action:(UIButton *)sender {
   
}

- (IBAction)actionsss:(id)sender {
     [_tagView changedDataSourceWithAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"navTitle";
//    self.tabBarItem.title = @"..";
//    self.view.backgroundColor = [UIColor blackColor];
////    
//    _tagView = [[HXVTagView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
//    _tagView.dataSource = self;
//    _tagView.delegate = self;
////
////    
////    [self.view addSubview:_tagView];
//    
//    _textView = [[UITextView alloc] init];
//    _textView.delegate = self;
//    [self.view addSubview:_textView];
//   // _textView.userInteractionEnabled = NO;
//    _textView.text = @"klkllklklklklkl";
//    _textView.font = [UIFont systemFontOfSize:16];
//    CGFloat height = [_textView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, 99999)].height;
//    _textView.frame = CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, height);
//    _textView.scrollEnabled = NO;
//    NSLog(@"%lf", height);
//    //_textView.textColor = [UIColor blackColor];
//    _textView.backgroundColor = [UIColor orangeColor];
//    
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _categoryView = [[HXVCategoryView alloc] init];
    _categoryView.frame = CGRectMake(0, 64, self.view.frame.size.width, 600);
    [self.view addSubview:_categoryView];
    _categoryView.dataSource = self;
    _categoryView.delegate = self;
    _categoryView.backgroundColor = [UIColor greenColor];
    
    
    [_categoryView reloadData];
}


////////////////

- (NSInteger)numberOfElementInCategoryView:(HXVCategoryView *)categoryView {
    return 5;
}

- (NSString *)categoryView:(HXVCategoryView *)categoryView titleForElement:(NSInteger)element {
    return [NSString stringWithFormat:@"hahahL:%zd", element];
}

////////////////


- (void)textViewDidChange:(UITextView *)textView {
    CGRect rect = _textView.frame;
    rect.size.height = [_textView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, 99999)].height;
    _textView.frame = rect;
    NSLog(@"%lf", rect.size.height);
}



- (NSInteger)numberOfRowsInTagView:(HXVTagView *)tagView {
    return 5;
}

- (UIEdgeInsets)tagView:(HXVTagView *_Nonnull)tagView edgeInsetsForRow:(NSInteger)row {
    switch (row) {
        case 0: case 2:
            return UIEdgeInsetsMake(0, 32, 0, 0);
            break;
        case 1: case 3:
            return UIEdgeInsetsMake(0, 0, 0, 32);
            break;
    }
    return UIEdgeInsetsZero;
}


- (CGFloat)tagView:(HXVTagView *)tagView widthForRow:(NSInteger)row {
    return HXVTagViewAutomaticDimension;
}

- (NSString *)tagView:(HXVTagView *)tagView titleForRow:(NSInteger)row {
    return @[@"12312312313",@"222",@"333",@"44",@"45555"][row];
}


- (NSString *)tagView:(HXVTagView *)tagView preparedTitleForRow:(NSInteger)row {
    return @[@"66666",@"7777",@"8888888",@"9999999",@"11112312312312"][row];
}


- (void)tagView:(HXVTagView *)tagView didSelectRow:(NSInteger)row {
    [tagView removeFromSuperview];
}

- (void)tagView:(HXVTagView *)tagView rowDidAnimate:(NSInteger)row rowView:(UIView *)view animationOption:(BOOL)isEaseOut {
    if (isEaseOut) {
        switch (row) {
            case 0: case 2: {
                CGRect rect = view.frame;
                rect.origin.x = -self.view.frame.size.width;
            }
                break;
            case 1: case 3: case 4: {
                CGRect rect = view.frame;
                rect.origin.x = self.view.frame.size.width;
            }
                break;
            default:
                break;
        }
    } else {
        switch (row) {
            case 0: case 2: {
                CGRect rect = view.frame;
                rect.origin.x = -self.view.frame.size.width;
            }
                break;
            case 1: case 3: {
                CGRect rect = view.frame;
                rect.origin.x = self.view.frame.size.width;
            }
                break;
            default:
                view.center = self.view.center;
                break;
        }
    }
}








/**
 *  版本比对
 *
 *  @param oldver 老的版本
 *  @param newver 心的版本
 *
 *  @return  是否更新Bool
 */
+ (BOOL)tggVersion:(NSString *)oldver lessthan:(NSString *)newver{
    return [oldver compare:newver options:NSCaseInsensitiveSearch] == NSOrderedAscending ? YES : NO;
}



- (IBAction)smsAction:(id)sender {
  //  [[AMASchemeManager shareManager] smsWithViewController:self];
   // [self showMessageView];
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
