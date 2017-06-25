//
//  EntSeedingModel.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/19.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntSeedingModel : NSObject


/** 电话号码 */
@property (nonatomic, copy) NSString *PHONE_NUM;

/** 苗木数量 */
@property (nonatomic, copy) NSString *SEDDLING_NUM;

/** 苗木种类 */
@property (nonatomic, copy) NSString *SEDDLING_TYPE;

/** 苗木图片 */
@property (nonatomic, copy) NSString *SEDDLING_URL;

/** 苗木胸径 */
@property (nonatomic, copy) NSString *SEDDLING_XJ;

/** 苗木价格 */
@property (nonatomic, copy) NSString *PRI;






@end
