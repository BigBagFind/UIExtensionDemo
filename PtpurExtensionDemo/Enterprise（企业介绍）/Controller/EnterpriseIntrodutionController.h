//
//  EnterpriseIntrodutionController.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseEnterpriseTableController.h"
#import "EnterpriseListModel.h"


typedef void(^DidScroll)(id);


@interface EnterpriseIntrodutionController : BaseEnterpriseTableController

@property (nonatomic, strong) EnterpriseListModel *model;

@end
