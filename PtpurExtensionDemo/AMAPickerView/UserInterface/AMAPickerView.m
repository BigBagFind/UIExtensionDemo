//
//  AMAPickerView.m
//  AMAPickerViewDemo
//
//  Created by 吴玉铁 on 2017/1/14.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "AMAPickerView.h"
#import "AMAPickerViewConst.h"

@interface AMAPickerView () <UIPickerViewDelegate, UIPickerViewDataSource, AMAPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *maskView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewBottomConstraint;

@end

@implementation AMAPickerView

- (void)setViewModel:(id<AMAPickerViewService>)viewModel {
    if (_viewModel != viewModel) {
        _viewModel = viewModel;
        [self initViews];
    }
}

#pragma mark - PickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [_viewModel numberOfComponents];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_viewModel numberOfRowsInComponent:component];
}

#pragma mark - PickerViewDelagate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }
    pickerLabel.text = [_viewModel titleForRow:row forComponent:component];
    return pickerLabel;
}




#pragma mark - AMAPickerViewDelegate
- (void)pickerViewWillPresent:(AMAPickerView *)pickerView {
    if ([_delegate respondsToSelector:@selector(pickerViewWillPresent:)]) {
        [_delegate pickerViewWillPresent:pickerView];
    }
}

- (void)pickerViewDidPresent:(AMAPickerView *)pickerView {
    if ([_delegate respondsToSelector:@selector(pickerViewDidPresent:)]) {
        [_delegate pickerViewDidPresent:pickerView];
    }
}

- (void)pickerViewWillDismiss:(AMAPickerView *)pickerView {
    if ([_delegate respondsToSelector:@selector(pickerViewWillDismiss:)]) {
        [_delegate pickerViewWillDismiss:pickerView];
    }
}

- (void)pickerViewDidDismiss:(AMAPickerView *)pickerView {
    if ([_delegate respondsToSelector:@selector(pickerViewDidDismiss:)]) {
        [_delegate pickerViewDidDismiss:pickerView];
    }
}

#pragma mark - UserInout
- (IBAction)bgButtonDidClicked:(id)sender {
    if (_viewModel.maskEnable) {
        [self dismissAnimation];
    }
}

- (IBAction)cancelButtonDidClicked:(id)sender {
    [self dismissAnimation];
}

- (IBAction)completedButtonDidClicked:(id)sender {
    [self dismissAnimation];
}

#pragma mark - Init
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializer];
    [self initViews];
    [self layoutViews];
    [self presentAnimation];
}

- (void)initViews {
    _titleLabel.text = self.viewModel.pickerTitle;
    _maskView.userInteractionEnabled = self.viewModel.maskEnable;
    _maskView.alpha = 0;
}

- (void)layoutViews {
    self.mainViewBottomConstraint.constant = -AMAPickerViewMainPickerHeight;
}

- (void)initializer {
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark - Animation
- (void)presentAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:AMAPickerViewAnimationDuration animations:^{
            _mainViewBottomConstraint.constant = 0;
            _maskView.alpha = 1.0;
            [self layoutIfNeeded];
            [self pickerViewWillPresent:self];
        } completion:^(BOOL finished) {
            if (finished) {
                [self pickerViewDidPresent:self];
            }
        }];
    });
}

- (void)dismissAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:AMAPickerViewAnimationDuration animations:^{
            _mainViewBottomConstraint.constant = -AMAPickerViewMainPickerHeight;
            _maskView.alpha = 0;
            [self layoutIfNeeded];
            [self pickerViewWillDismiss:self];
        } completion:^(BOOL finished) {
            if (finished) {
                [self pickerViewDidDismiss:self];
                [self removeFromSuperview];
            }
        }];
    });
}




@end
