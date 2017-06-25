//
//  ImageBrower.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBrower : UIView



/** imageUrl数组 */
@property (nonatomic, strong) NSMutableArray *urlData;


+ (instancetype)viewFromNib;




@end
