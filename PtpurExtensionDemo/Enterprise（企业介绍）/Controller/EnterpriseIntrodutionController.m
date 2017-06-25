//
//  EnterpriseIntrodutionController.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "EnterpriseIntrodutionController.h"
#import "EnterpriseHonorCell.h"
#import "EnterpriseIntroductionCell.h"
#import "EntHonorModel.h"

static NSString *identifier = @"EnterpriseHonorCell";
static NSString *identifier2 = @"EnterpriseIntroductionCell";

@interface EnterpriseIntrodutionController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *urlArray;


@property (nonatomic, strong) NSString *honorList;


@property (nonatomic, strong) EntHonorModel *honorModel;

/** 企业资质高度 */
@property (nonatomic, assign) CGFloat honorHeight;

/** 企业介绍高度 */
@property (nonatomic, assign) CGFloat desHeight;


@end

@implementation EnterpriseIntrodutionController


- (NSMutableArray *)urlArray {
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [self.loadingCell reloadHandle:^{
        @strongify(self);
        [self fetchData];
    }];
    
}




#pragma mark - UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isLoaded) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLoaded) {
        if (indexPath.row == 0) {
            EnterpriseHonorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.model = self.honorModel;
            return cell;
        } else {
            EnterpriseIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            cell.introduction.text = self.model.JS;
            return cell;
        }
    } else {
        return self.loadingCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLoaded) {
        if (indexPath.row == 0) {
            return self.honorHeight;
        } else {
            return self.desHeight;
        }
    } else {
        return kScreenHeight - 64 - 40;
    }
}

- (void)fetchData {
    if (self.isLoaded == YES) {
        return ;
    }
    [self fetchIntroduction];
}

- (void)fetchIntroduction {
    NSDictionary *params = @{
                             @"ID" : self.model.C_ID
                            };
    TggLog(@"%@",params);
    [TggDataService TggAFrequestUrlString:EnterpriseIntroduction HTTPMethod:@"POST" params:[params mutableCopy] progressHandle:^(NSProgress *progress) {
        
    } completionHandle:^(id result) {
        TggLog(@"fetchEnterpriseIntroduction:\n%@",result);
        if (TggNetSucceed) {
            // 处理企业介绍高度
            self.desHeight = [TggEasyTool tggEasyGetTextHeightWithText:self.model.JS width:kScreenWidth - 16 fontSize:13 linespace:0] + 44 + 8 + 12;
            // 转换模型
            self.honorList = [[NSString alloc] init];
            NSArray *list = result[@"data"][@"NATlist"];
            for (NSUInteger i = 0; i < list.count; i ++) {
                NSDictionary *dic = list[i];
                [self.urlArray addObject:[dic objectForKey:@"URL"]];
                NSString *appendStr = (i == list.count - 1) ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"NAME"]] : [NSString stringWithFormat:@"%@\n",[dic objectForKey:@"NAME"]];
                self.honorList = [self.honorList stringByAppendingString:appendStr];
            }
            
          NSArray *data =  @[
                               @"http://oclszdbuf.bkt.clouddn.com/web/app/display5.png",
                               @"http://oclszdbuf.bkt.clouddn.com/web/app/icon.png",
                               @"http://b.zol-img.com.cn/sjbizhi/images/6/208x312/1394701139813.jpg",
                               @"http://img.jj20.com/up/allimg/911/0P315132137/150P3132137-1-lp.jpg",
                               @"http://b.zol-img.com.cn/sjbizhi/images/1/208x312/1350915106394.jpg",
                               @"http://b.zol-img.com.cn/sjbizhi/images/8/208x312/1427966117121.jpg",
                               @"http://img.jj20.com/up/allimg/811/052515103222/150525103222-1-lp.jpg",
                               @"http://b.zol-img.com.cn/sjbizhi/images/8/208x312/1435742799400.jpg",
                               @"http://imga1.pic21.com/bizhi/131016/02507/s11.jpg"
                               ];
            self.urlArray = [NSMutableArray arrayWithArray:data];
            // 构建模型
            self.honorModel = [[EntHonorModel alloc] init];
            self.honorModel.urlArray = self.urlArray;
            self.honorModel.honorList = self.honorList;
            // 处理企业资质高度
            self.honorHeight = list.count * [TggEasyTool tggEasyGetTextHeightWithText:@"测高度" width:kScreenWidth - 8 - 52 fontSize:13 linespace:5] + 96 + 24;
            // 更新状态
            self.isLoaded = YES;
            // 补充高度
            [self fillContentWithRowHeight:0 count:self.dataSource.count supplement:self.desHeight + self.honorHeight];
            // 刷新数组
            [self.tableView reloadData];
            // 结束刷新
            [self.loadingCell endLoading];
            
        } else {
            [self.loadingCell failedLoading];
            [self tgg_showAutoWarning:TggNetMsg];
        }
    } errorHandle:^(NSError *error) {
        TggLog(@"fetchEnterpriseIntroduction:\n%@",error.userInfo);
        [self.loadingCell failedLoading];
        [self tgg_showAndHandleError:error];
    }];
}






@end
