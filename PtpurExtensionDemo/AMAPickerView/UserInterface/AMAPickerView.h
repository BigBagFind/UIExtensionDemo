//
//  AMAPickerView.h
//  AMAPickerViewDemo
//
//  Created by 吴玉铁 on 2017/1/14.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMAPickerViewDelegate.h"
#import "AMAPickerViewService.h"

@interface AMAPickerView : UIView

@property (weak, nonatomic) id<AMAPickerViewDelegate> delegate;
@property (strong, nonatomic) id<AMAPickerViewService> viewModel;

@end
