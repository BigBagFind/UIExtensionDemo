//
//  ImageBrower.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/12.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "ImageBrower.h"
#import "UIImageView+WebCache.h"
#import "STPhotoBrowserController.h"
#import "STConfig.h"


static CGFloat const itemWidth = 80;

static CGFloat const margin = 16;

static NSString *const identifier = @"ImageCell";

@interface ImageBrower ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,STPhotoBrowserDelegate> {
    NSIndexPath *_currentIndexPath;
}

/** 后退按钮 */
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

/** 前进按钮 */
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

/** the CollectionView */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;





@end


@implementation ImageBrower



+ (instancetype)viewFromNib {
    ImageBrower *imageBrower = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] lastObject];
    return imageBrower;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}


- (void)initialize {
    
    _currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.collectionViewLayout = layout;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.scrollsToTop = NO;
    _collectionView.directionalLockEnabled = YES;
    _collectionView.alwaysBounceVertical = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_collectionView setContentOffset:CGPointMake(16, 0)];
}


#pragma mark - 左右箭头点击事件
- (IBAction)arrowAction:(UIButton *)sender {

    if (sender == self.leftButton) {
        if (_currentIndexPath.item == 0) {
            return ;
        }
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndexPath.item - 1 inSection:_currentIndexPath.section] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    } else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndexPath.item + 1 inSection:_currentIndexPath.section] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}



#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index {
    UICollectionViewCell *cell = [self collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    UIImageView *imageView = (UIImageView *)cell.backgroundView;
    return imageView.image;
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSString *urlStr = self.urlData[index];
    return [NSURL URLWithString:urlStr];
}


#pragma mark - CollecitonViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.urlData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    
    cell.backgroundView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.urlData[indexPath.item]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, margin, 0, margin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = self.collectionView; // 原图的父控件
    browserVc.countImage = self.urlData.count; // 图片总数
    browserVc.currentPage = indexPath.item;
    browserVc.delegate = self;
    [browserVc show];
}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / (itemWidth + margin);
    _currentIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
}


#pragma mark - 重写Getter
//- (NSMutableArray *)urlData {
//    if (!_urlData) {
//        NSArray *data =  @[@"http://img.jj20.com/up/allimg/911/121215132T8/151212132T8-1-lp.jpg",
//                 @"http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1396940684766.jpg",
//                 @"http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1394701139813.jpg",
//                 @"http://img.jj20.com/up/allimg/911/0P315132137/150P3132137-1-lp.jpg",
//                 @"http://b.zol-img.com.cn/sjbizhi/images/1/208x312/1350915106394.jpg",
//                 @"http://b.zol-img.com.cn/sjbizhi/images/8/208x312/1427966117121.jpg",
//                 @"http://img.jj20.com/up/allimg/811/052515103222/150525103222-1-lp.jpg",
//                 @"http://b.zol-img.com.cn/sjbizhi/images/8/208x312/1435742799400.jpg",
//                 @"http://imga1.pic21.com/bizhi/131016/02507/s11.jpg"];
//        _urlData = [NSMutableArray arrayWithArray:data];
//    }
//    return _urlData;
//}


- (void)setUrlData:(NSMutableArray *)urlData {
    if (_urlData != urlData) {
        _urlData = urlData;
        if (urlData.count > 0) {
            [self.collectionView reloadData];
        }
    }
}



@end
















