//
//  AMAPickerViewDelegate.h
//  AMAPickerViewSecondDemo
//
//  Created by 吴玉铁 on 2017/1/15.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMAPickerView;
@protocol AMAPickerViewDelegate <NSObject>

- (void)pickerViewWillDismiss:(AMAPickerView *)pickerView;

- (void)pickerViewDidDismiss:(AMAPickerView *)pickerView;

- (void)pickerViewWillPresent:(AMAPickerView *)pickerView;

- (void)pickerViewDidPresent:(AMAPickerView *)pickerView;

@end
