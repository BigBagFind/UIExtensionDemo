//
//  AMAPickerViewViewModel.m
//  AMAPickerViewSecondDemo
//
//  Created by 吴玉铁 on 2017/1/15.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "AMAPickerViewViewModel.h"

@interface AMAPickerViewViewModel ()

@property (nonatomic, assign) BOOL maskEnable;
@property (nonatomic, copy) NSString *pickerTitle;

@end

@implementation AMAPickerViewViewModel

- (instancetype)initWithDataSource:(NSArray *)dataSource {
    self = [super init];
    if (self) {
        _pickerTitle = nil;
        _maskEnable = YES;
    }
    return self;
}

#pragma mark - DataSource
- (NSInteger)numberOfComponents {
    return 2;
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

#pragma mark - Delegate
- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row % 2 == 0) {
        return @"asdhsdl阿森dasd";
    }
    return @"完";
}







/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        PickerAreaModel *model = self.provinces[row];
        return model.name;
    } else if (component == 1){
        PickerAreaModel *model = self.cities[row];
        return model.name;
    } else if (component == 2){
        PickerAreaModel *model = self.regions[row];
        return model.name;
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        PickerAreaModel *provinceModel = self.provinces[row];
        NSMutableArray *temp = [NSMutableArray array];
        if (provinceModel.subArea.count > 0) {
            for (NSDictionary *dic in provinceModel.subArea) {
                PickerAreaModel *model = [PickerAreaModel new];
                model.name = [dic objectForKey:@"name"];
                model.subArea = [dic objectForKey:model.name];
                [temp addObject:model];
            }
            self.cities = temp;
            _provinceIndex = row;
            PickerAreaModel *cityModel = [self.cities firstObject];
            NSMutableArray *temp = [NSMutableArray array];
            if (cityModel.subArea.count > 0) {
                for (NSDictionary *dic in cityModel.subArea) {
                    PickerAreaModel *model = [PickerAreaModel new];
                    model.name = [dic objectForKey:@"name"];
                    model.subArea = [dic objectForKey:model.name];
                    [temp addObject:model];
                }
                self.regions = temp;
                _cityIndex = 0;
                _regionIndex = 0;
            }
            [_pickerView reloadComponent:1];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
        }
    } else if (component == 1) {
        PickerAreaModel *cityModel = self.cities[row];
        NSMutableArray *temp = [NSMutableArray array];
        if (cityModel.subArea.count > 0) {
            for (NSDictionary *dic in cityModel.subArea) {
                PickerAreaModel *model = [PickerAreaModel new];
                model.name = [dic objectForKey:@"name"];
                [temp addObject:model];
            }
            self.regions = temp;
            _cityIndex = row;
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
        }
    } else if (component == 2) {
        _regionIndex = row;
        
    }
    
}
*/



@end


