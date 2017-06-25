//
//  EnterpriseSeedingCell.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntSeedingModel.h"

@interface EnterpriseSeedingCell : UITableViewCell


/** 左边图标 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;

/** 树种名称 */
@property (weak, nonatomic) IBOutlet UILabel *seedingName;

/** 树种数量 */
@property (weak, nonatomic) IBOutlet UILabel *count;

/** 树种规格 */
@property (weak, nonatomic) IBOutlet UILabel *size;

/** 树种价格 */
@property (weak, nonatomic) IBOutlet UILabel *price;

/** 数据模型 */
@property (nonatomic, strong) EntSeedingModel *model;




@end
