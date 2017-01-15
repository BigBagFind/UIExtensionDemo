//
//  AMAPickerViewViewModelService.h
//  AMAPickerViewSecondDemo
//
//  Created by 吴玉铁 on 2017/1/15.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AMAPickerViewService <NSObject>

@property (nonatomic, assign, readonly) BOOL maskEnable;
@property (nonatomic, copy, readonly) NSString *pickerTitle;

@required
- (NSInteger)numberOfComponents;

- (NSInteger)numberOfRowsInComponent:(NSInteger)component;

@optional
- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@end
