//
//  LoadingCell.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/19.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell



- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (IBAction)reloadAction:(UIButton *)sender {
    if (self.reloadBlock) {
       self.reloadBlock();
    }
    [self startLoading];
}


- (void)startLoading {
    [self.indicator startAnimating];
    self.reloadButton.hidden = YES;
}


- (void)endLoading {
    [self.indicator stopAnimating];
    self.reloadButton.hidden = YES;
}


- (void)failedLoading {
    [self.indicator stopAnimating];
    self.reloadButton.hidden = NO;
}


- (void)reloadHandle:(void (^)(void))reloadblock {
    self.reloadBlock = ^ {
        reloadblock();
    };
}













@end
