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
    

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"This is an example by www.baidu.com sdadad"];
    
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"username://marcelofabri_"
                             range:[[attributedString string] rangeOfString:@"www.baidu.com"]];
//    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor greenColor],
//                                     NSUnderlineColorAttributeName: [UIColor redColor],
//                                     NSUnderlineStyleAttributeName: @(NSUnderlineStyleThick)};
//    
    self.textView.attributedText = [attributedString copy];
   // self.textView.linkTextAttributes = linkAttributes;
    self.textView.editable = NO;
    self.textView.delegate = self;
    
    　　// Example using fonts and colours
    
//    　　NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:18.0],
//                               
//                               @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0],
//                               
//                               　@"red": [UIColor redColor]};
//    self.textView.linkTextAttributes = style1;
    　　// Example using arrays of styles, dictionary attributes for underlining and image styles
//    
    
//    　　// Example using blocks for actions when text is tapped. Uses the 'link' attribute to style the links
    
    　　NSDictionary* style3 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:22.0],
                               
                               　　@"help":[WPAttributedStyleAction styledActionWithAction:^{
                                   
                                   　　NSLog(@"Help action");
                                   
                                   　　}],
                               
                               　　@"settings":[WPAttributedStyleAction styledActionWithAction:^{
                                   
                                   　　NSLog(@"Settings action");
                                   
                                   　　}],
                               
                               　　@"link": [UIColor orangeColor]};
    self.textView.linkTextAttributes = style3;
//    　　self.label1.attributedText = [@"AttributedBoldRedtext" attributedStringWithStyleBook:style1];
//    
//    　　self.label2.attributedText = [@"[td]Multiplestylestext[td]" attributedStringWithStyleBook:style2];
//    
    
//    //颜色
//    [mutStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 10)];
//    //字体
//    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(20, 5)];
//    //下划线
//    [mutStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternDot) range:NSMakeRange(32, 8)];
    //空心字
  //  [mutStr addAttribute:NSStrokeWidthAttributeName value:@(2) range:NSMakeRange(42, 5)];
   
   // self.textView.attributedText
    
    
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
