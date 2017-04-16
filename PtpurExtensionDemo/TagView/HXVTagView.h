//
//  HXVTagView.h
//  HXVTagViewDemo
//
//  Created by Wuyutie on 2017/4/16.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import <UIKit/UIKit.h>

extern  const CGFloat HXVTagViewAutomaticDimension;

@class HXVTagView;
@protocol HXVTagViewDataSource <NSObject>

@required

// returns the number of 'rows' to display.
- (NSInteger)numberOfRowsInTagView:(HXVTagView *_Nonnull)tagView;

@optional


///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

@end

@protocol HXVTagViewDelegate <NSObject>

@optional

// returns width of width and height for each row.
- (CGFloat)tagView:(HXVTagView *_Nonnull)tagView widthForRow:(NSInteger)row;

- (CGFloat)tagView:(HXVTagView *_Nonnull)tagView heightForRow:(NSInteger)row;

// returns insetEdge to adjust item content, default UIEdgeZero
- (UIEdgeInsets)tagView:(HXVTagView *_Nonnull)tagView edgeInsetsForRow:(NSInteger)row;

// return a plain NSString to display the row.
// If you return nil, the row width will be half of whole
- (nullable NSString *)tagView:(HXVTagView *_Nonnull)tagView titleForRow:(NSInteger)row;

// return a plain NSString to display the Animation row.
// If you return nil, never execute animation
- (nullable NSString *)tagView:(HXVTagView *_Nonnull)tagView preparedTitleForRow:(NSInteger)row;

- (void)tagView:(HXVTagView *_Nonnull)tagView didSelectRow:(NSInteger)row;

- (void)tagView:(HXVTagView *_Nonnull)tagView rowDidAnimate:(NSInteger)row rowView:(UIView *_Nullable)view animationOption:(BOOL)isEaseOut;

@end


///////////////////////////////////////////////////////
///////////////////////////////////////////////////////


@interface HXVTagView : UIView

// default is nil. weak reference
@property (nonatomic, weak, nullable) id <HXVTagViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <HXVTagViewDelegate> delegate;

// default is nil
@property (nonatomic, assign) CGFloat minimumLineSpacing;

// default is 44
@property (nonatomic, assign) CGFloat rowHeight;

// info that was fetched and cached from the data source
@property(nonatomic, assign, readonly) NSInteger numberOfRows;

// returns selected row. -1 if nothing selected
@property(nonatomic, assign, readonly) NSInteger selectedRow;

// Reloading whole view
- (void)reloadData;

- (void)changedDataSourceWithAnimated:(BOOL)animated;


@end




