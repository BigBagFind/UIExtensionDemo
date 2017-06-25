//
//  HXVProfitAbilityService.m
//  TabHoverViewDemo
//
//  Created by Wuyutie on 2017/6/25.
//  Copyright © 2017年 Wuyutie. All rights reserved.
//

#import "HXVProfitAbilityService.h"

@implementation HXVProfitAbilityService



- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 10;
}

// ReuseIdentifier must equal to class name
- (NSArray<NSString *> *)cellReuseIdentifiers {
    return @[@"UITableViewCell"];
}

- (NSString *)reusableCellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"UITableViewCell";
}



@end
