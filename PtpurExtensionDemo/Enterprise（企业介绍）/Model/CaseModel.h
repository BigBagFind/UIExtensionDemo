//
//  CaseModel.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/20.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseModel : NSObject


/** 案例名称 */
@property (nonatomic, copy) NSString *NAME;

/** 字符串url */
@property (nonatomic, copy) NSString *URL;

/** 工程介绍 */
@property (nonatomic, copy) NSString *JS;

/** 时间 */
@property (nonatomic, copy) NSString *FRIST_TIME;

/** url数组 */
@property (nonatomic, strong) NSArray *urlArray;

/** cell的高度 */
@property (nonatomic, assign) CGFloat height;





@end
