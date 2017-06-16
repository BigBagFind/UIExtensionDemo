//
//  HXVCategoryView.h
//  PtpurExtensionDemo
//
//  Created by Wuyutie on 2017/6/17.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HXVCategoryTitleState) {
    HXVCategoryTitleStateNormal = 0,
    HXVCategoryTitleStateHighlighted,
    HXVCategoryTitleStateSelected
};


@class HXVCategoryView;
@protocol HXVCategoryViewDataSource <NSObject>

@required

// returns the number of 'elements' to display.
- (NSInteger)numberOfElementInCategoryView:(HXVCategoryView *_Nonnull)categoryView;

// return a plain NSString to display the element.
// If you return nil, the element will be @""
- (nullable NSString *)categoryView:(HXVCategoryView *_Nonnull)categoryView titleForElement:(NSInteger)element;

// If you return nil, return empty view
- (nullable UIView *)categoryView:(HXVCategoryView *_Nonnull)categoryView viewForElement:(NSInteger)element;

@optional


@end
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////


@class HXVCategoryView;
@protocol HXVCategoryViewDelegate <NSObject>

@required


@optional

@end

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////


// USING WARNING!
// The view depend on Masonry inside, the project should import it.

@interface HXVCategoryView : UIView

// default is nil. weak reference
@property (nonatomic, weak, nullable) id <HXVCategoryViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <HXVCategoryViewDelegate> delegate;

@property (nonatomic, strong) UIColor * _Nullable categoryTitleColor;


- (void)reloadData;

- (void)setCategoryTitleColor:(UIColor *_Nullable)color forState:(HXVCategoryTitleState)state;


@end
