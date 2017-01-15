//
//  AMAPickerViewInteractor.h
//  AMAPickerViewSecondDemo
//
//  Created by 吴玉铁 on 2017/1/15.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMAPickerViewDelegate.h"
#import "AMAPickerViewService.h"
#import "AMAPickerView.h"

@interface AMAPickerViewInteractor : NSObject
NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, strong, readonly) AMAPickerView *pickerView;

+ (instancetype)interactorWithViewModel:(nonnull id<AMAPickerViewService>)viewModel;
- (instancetype)initWithViewModel:(nonnull id<AMAPickerViewService>)viewModel;

- (void)presentPickerView;


NS_ASSUME_NONNULL_END
@end
