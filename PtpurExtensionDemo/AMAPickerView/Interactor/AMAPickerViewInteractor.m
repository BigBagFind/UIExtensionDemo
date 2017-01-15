//
//  AMAPickerViewInteractor.m
//  AMAPickerViewSecondDemo
//
//  Created by 吴玉铁 on 2017/1/15.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "AMAPickerViewInteractor.h"

@implementation AMAPickerViewInteractor

+ (instancetype)interactorWithViewModel:(id<AMAPickerViewService>)viewModel {
    return [[self alloc] initWithViewModel:viewModel];
}

- (instancetype)initWithViewModel:(id<AMAPickerViewService>)viewModel {
    self = [super init];
    if (self) {
        _pickerView = [self createPickerView];
        _pickerView.viewModel = viewModel;
    }
    return self;
}

- (void)presentPickerView {
    _pickerView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
    [_pickerView layoutIfNeeded];
}

#pragma mark - Factory
- (AMAPickerView *)createPickerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMAPickerView class]) owner:self options:nil] lastObject];
}



@end
