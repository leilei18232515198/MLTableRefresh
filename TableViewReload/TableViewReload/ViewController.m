//
//  ViewController.m
//  TableViewReload
//
//  Created by 268Edu on 2018/10/19.
//  Copyright © 2018年 QRScan. All rights reserved.
//

#import "ViewController.h"
#import "MLRefreshHead.h"
#define width   [UIScreen mainScreen].bounds.size.width
#define height   [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据",@"下拉刷新数据"];
    [self.view addSubview:self.tableview];
    
    __weak typeof(self) weakSelf = self;
    self.tableview.mj_header = [MLRefreshHead headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableview.mj_header endRefreshing];
        });
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (self) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.text = self.array[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
@end
