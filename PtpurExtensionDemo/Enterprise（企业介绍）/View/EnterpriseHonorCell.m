//
//  EnterpriseHonorCell.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "EnterpriseHonorCell.h"
#import "Masonry.h"

@interface EnterpriseHonorCell ()





@end



@implementation EnterpriseHonorCell


- (ImageBrower *)imageBrower {
    if (!_imageBrower) {
        _imageBrower = [ImageBrower viewFromNib];
    }
    return _imageBrower;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.imageBrower];
    self.imageBrower.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.imageBrower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(24);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(96);
    }];
    
    [self.honorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBrower.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(52);
        make.right.equalTo(self.contentView.mas_right).offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageBrower.urlData = [self.model.urlArray mutableCopy];
    
    self.honorLabel.text = self.model.honorList;
    
}

- (void)setModel:(EntHonorModel *)model {
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}




@end
