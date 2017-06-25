//
//  EnterpriseController.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "BaseViewController.h"
#import "EnterpriseListModel.h"


@interface EnterpriseController : BaseViewController



@property (nonatomic, strong) EnterpriseListModel *model;



/** 当前高度 */
@property (nonatomic, assign) CGFloat currentOffset;


@end
