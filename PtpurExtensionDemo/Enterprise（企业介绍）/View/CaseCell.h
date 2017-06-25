//
//  CaseCell.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseModel.h"
#import "ImageBrower.h"


@interface CaseCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *projectName;

@property (weak, nonatomic) IBOutlet UILabel *projectDes;

@property (nonatomic, strong) ImageBrower *imageBrower;

@property (nonatomic, strong) CaseModel *model;



@end
