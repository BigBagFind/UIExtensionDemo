//
//  AMAPickerViewViewModel.h
//  AMAPickerViewSecondDemo
//
//  Created by 吴玉铁 on 2017/1/15.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMAPickerViewService.h"

@interface AMAPickerViewViewModel : NSObject <AMAPickerViewService>

@property (nonatomic, assign, readonly) BOOL maskEnable;
@property (nonatomic, copy, readonly) NSString *pickerTitle;


- (instancetype)initWithDataSource:(NSArray *)dataSource;

@end
