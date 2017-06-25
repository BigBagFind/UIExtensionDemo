//
//  EnterpriseHonorCell.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageBrower.h"
#import "EntHonorModel.h"

@interface EnterpriseHonorCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *honorLabel;

@property (nonatomic, strong) ImageBrower *imageBrower;


@property (nonatomic, strong) EntHonorModel *model;


@end
