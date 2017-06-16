//
//  TextViewController.m
//  TestEnum
//
//  Created by Wuyutie on 2017/4/13.
//  Copyright © 2017年 Wuyutie. All rights reserved.
//

#import "TextViewController.h"


@interface TextViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    
    
    
    
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"This is an example by www.baidu.com sdadad"];
//    
//    [attributedString addAttribute:NSLinkAttributeName
//                             value:@"username://marcelofabri_"
//                             range:[[attributedString string] rangeOfString:@"www.baidu.com"]];
//    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor greenColor],
//                                     NSUnderlineColorAttributeName: [UIColor redColor],
//                                     NSUnderlineStyleAttributeName: @(NSUnderlineStyleThick)};
//    
//    self.textView.attributedText = [attributedString copy];
//   // self.textView.linkTextAttributes = linkAttributes;
//    self.textView.editable = NO;
//    self.textView.delegate = self;
//    

    
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
}

@end
