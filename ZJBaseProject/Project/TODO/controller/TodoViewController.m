//
//  TodoViewController.m
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "TodoViewController.h"
#import "AddViewController.h"
#import "TodoTableViewCell.h"
#import "Realm.h"
#import "NSDate+Utilities.h"
#import "TodoHeaderView.h"

@interface TodoViewController ()<UITableViewDelegate, UITableViewDataSource, TodoTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray <NSMutableArray *> *sectionArray;
@end

@implementation TodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

-(void)prepareUI{
    self.title = @"待办事项";
    [self.view addSubview:self.tableView];
    [self dateArrayInit];
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside | UIControlEventAllTouchEvents];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = add;
}

-(void)dateArrayInit{
    [self.sectionArray removeAllObjects];
    RLMResults<TodoModel *> *results = [TodoModel allObjects];
    NSMutableArray <TodoModel *> *superArray = [[NSMutableArray alloc] init];
    for (TodoModel *model in results) {
        [superArray addObject:model];
    }    
    NSMutableArray *yearArr = [[NSMutableArray alloc] init];
    NSArray <TodoModel *>*dateArr = [superArray sortedArrayUsingComparator:^NSComparisonResult(TodoModel *obj1, TodoModel *obj2) {
        return [obj2.date compare:obj1.date];
    }];
    for (TodoModel *model in dateArr) {
        if (![yearArr containsObject:@(model.year)]) {
            [yearArr addObject:@(model.year)];
        }
    }

    for (NSNumber *year in yearArr) {
        NSMutableArray <TodoModel *> *arr = [[NSMutableArray alloc] init];
        for (TodoModel *model in dateArr) {
            if ([year integerValue] == model.year) {
                [arr addObject:model];
            }
        }
        [self.sectionArray addObject:arr];
    }
}


#pragma mark: --- UITableViewDelegate, UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    TodoHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TodoHeaderView"];
    TodoHeaderView *header = [[TodoHeaderView alloc] init];
    header.model = self.sectionArray[section][0];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionArray[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodoTableViewCell *cell = (TodoTableViewCell * )[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGSize size = [cell.rootLayout sizeThatFits:CGSizeMake(SCREEN_W - 30, 0)];
    return size.height + 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"TodoTableViewCell";
    TodoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[TodoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.sectionArray[indexPath.section][indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 15)];
    return view;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    [self endEditing];
    TodoTableViewCell *cell = (TodoTableViewCell * )[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    cell.editing = YES;
    return YES;
}

#pragma mark: --- TodoTableViewCellDelegate
- (void)editOrDeleteModel:(TodoModel *)mdoel isEdit:(BOOL)isEdit indexPath:(NSIndexPath *)indexPath{
    if (isEdit) {
        [self endEditing];
        AddViewController *VC = [[AddViewController alloc] init];
        VC.model = mdoel;
        VC.didFinishedAddAndEdit = ^(TodoModel *model) {
            [self.tableView reloadData];
        };
        [self.navigationController presentViewController:VC animated:YES completion:nil];
    }else{
        [self dateArrayInit];
        [self.tableView reloadData];
    }
}

-(void)endEditing{
    for (NSIndexPath *path in [self.tableView indexPathsForVisibleRows]) {
        TodoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
        cell.editing = NO;
    }
}


#pragma mark: --- action
-(void)addBtnClick:(UIButton *)btn{
    btn.highlighted = NO;
    [self endEditing];
    [UIView animateWithDuration:0.35 animations:^{
        btn.transform = CGAffineTransformMakeScale(0.6, 0.6);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            [UIView animateWithDuration:0.35 animations:^{
                 btn.transform = CGAffineTransformIdentity;
             }];
        } completion:^(BOOL finished) {
            AddViewController *VC = [[AddViewController alloc] init];
            VC.model = [[TodoModel alloc] init];
            VC.didFinishedAddAndEdit = ^(TodoModel *model) {
                [self dateArrayInit];
                [self.tableView reloadData];
            };
            [self.navigationController presentViewController:VC animated:YES completion:nil];
        }];
    }];
}

#pragma mark: --- lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 60) style:UITableViewStylePlain];
        _tableView.backgroundColor = [ColorManager colorWithLightColorStr:@"#ffffff" DarkColor:@"#333333"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}


@end
