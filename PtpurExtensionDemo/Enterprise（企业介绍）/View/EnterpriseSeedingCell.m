//
//  EnterpriseSeedingCell.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "EnterpriseSeedingCell.h"



@implementation EnterpriseSeedingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(EntSeedingModel *)model {
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.seedingName.text = [NSString stringWithFormat:@"树种：%@",self.model.SEDDLING_TYPE];
    
    self.count.text = [NSString stringWithFormat:@"数量：%@",self.model.SEDDLING_NUM];
    
    self.size.text = [NSString stringWithFormat:@"规格范围：胸径%@",[TggEasyTool tggAlterDoubleStringWithVerticalBar:self.model.SEDDLING_XJ]];
    
    self.price.text = [NSString stringWithFormat:@"¥：%@",self.model.PRI];
    
}





@end
