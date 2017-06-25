//
//  LoadingCell.h
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/19.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingCell : UITableViewCell





@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

@property (nonatomic, copy) void(^reloadBlock)(void);


/** 结束加载 */
- (void)endLoading;

/** 加载失败 */
- (void)failedLoading;

/** 重新加载 */
- (void)reloadHandle:(void (^)(void))reloadblock;



@end
