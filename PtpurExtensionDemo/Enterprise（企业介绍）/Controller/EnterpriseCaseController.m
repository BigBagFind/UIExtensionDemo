//
//  EnterpriseCaseController.m
//  miaomiao
//
//  Created by 铁拳科技 on 16/9/11.
//  Copyright © 2016年 铁拳科技. All rights reserved.
//

#import "EnterpriseCaseController.h"
#import "CaseCell.h"
#import "NSString+SplitByBar.h"

static NSString *identifier = @"CaseCell";

@interface EnterpriseCaseController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EnterpriseCaseController




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
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count > 0) {
        CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.model = self.dataSource[indexPath.row];
        return cell;
    } else {
        return self.loadingCell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count > 0) {
        CaseModel *model = self.dataSource[indexPath.row];
        return model.height;
    } else {
        return kScreenHeight - 64 - 40;
    }
}



#pragma mark - 请求典型案例列表
- (void)fetchData {
    if (self.isLoaded == YES) {
        return ;
    }
    [self fetchCaseList];
}

- (void)fetchCaseList {
    NSDictionary *params = @{
                             @"ID" : self.model.C_ID
                            };
    TggLog(@"%@",params);
    [TggDataService TggAFrequestUrlString:EnterpriseCaseList HTTPMethod:@"POST" params:[params mutableCopy] progressHandle:^(NSProgress *progress) {
        
    } completionHandle:^(id result) {
        TggLog(@"fetchEnterpriseIntroduction:\n%@",result);
        if (TggNetSucceed) {
            // 转换模型
            self.dataSource = [NSMutableArray arrayWithArray:[CaseModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"ALlist"]]];
            CGFloat tableHeight = 0;
            // 计算高度
            for (CaseModel *model in self.dataSource) {
                model.JS = @"回答肯定卡顿拉到拉黑dasd 啦啦到啦办法啊啊说大师打打大哈回答肯定卡顿拉到拉黑dasd 啦啦到啦办法啊啊说大师打打大哈回答肯定卡顿拉到拉黑dasd 啦啦到啦办法啊啊说大师打打大哈";
                CGFloat height = [TggEasyTool tggEasyGetTextHeightWithText:model.JS width:kScreenWidth - 20 fontSize:13 linespace:0];
                CGFloat totalHeight = 52 + height + 96 + 8;
                model.height = totalHeight;
                model.urlArray = [model.URL componentsSeparatedByString:@"|"];
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
                model.urlArray = data;
                tableHeight += totalHeight;
            }
            // 补充高度
            [self fillContentWithRowHeight:0 count:self.dataSource.count supplement:tableHeight];
            
            // 刷新数组
            [self.tableView reloadData];
            
            // 结束刷新
            [self.loadingCell endLoading];
            // 更新状态
            self.isLoaded = YES;
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
