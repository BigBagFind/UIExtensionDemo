//
//  CaseCell.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "CaseCell.h"
#import "Masonry.h"

@interface CaseCell ()



@end


@implementation CaseCell


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
        make.top.equalTo(self.projectDes.mas_bottom).offset(4);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-4);
    }];
    
  
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.time.text = [NSString stringWithFormat:@"%@",self.model.FRIST_TIME];
    
    self.projectName.text = [NSString stringWithFormat:@"%@",self.model.NAME];
    
    self.projectDes.text = [NSString stringWithFormat:@"%@",self.model.JS];
 
    self.imageBrower.urlData = [self.model.urlArray mutableCopy];
    
    
}


- (void)setModel:(CaseModel *)model {
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}







@end
