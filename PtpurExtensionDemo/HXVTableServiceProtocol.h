//
//  HXVTableControllerProtocol.h
//  TabHoverViewDemo
//
//  Created by Wuyutie on 2017/6/25.
//  Copyright © 2017年 Wuyutie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HXVTableServiceProtocol <NSObject>

@required
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

// ReuseIdentifier must equal to class name
- (NSArray<NSString *> *)cellReuseIdentifiers;

- (NSString *)reusableCellIdentifierAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfSectionsInTableView;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
