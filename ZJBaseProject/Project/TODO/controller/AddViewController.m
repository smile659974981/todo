//
//  AddViewController.m
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "AddViewController.h"
#import "NSDate+Utilities.h"
#import "Realm.h"

@interface AddViewController ()<QMUITextViewDelegate>

@property(nonatomic,strong)MyRelativeLayout *rootLayout;
@property(nonatomic,strong)QMUIButton *cancelBtn;
@property(nonatomic,strong)QMUIButton *confirmBtn;
@property(nonatomic,strong)QMUITextView *titleTV;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSDate *oldDate;
@property(nonatomic,strong)NSArray <NSNumber *>*weedDayArray;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

-(void)prepareUI{
    [self.view addSubview:self.rootLayout];
    self.weedDayArray = @[@0, @7, @1, @2, @3, @4, @5, @6];

    [self.rootLayout addSubview:self.cancelBtn];
    [self.rootLayout addSubview:self.confirmBtn];
    [self.rootLayout addSubview:self.titleTF];
    [self.rootLayout addSubview:self.datePicker];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.titleTF becomeFirstResponder];
    });
    self.oldDate = self.model.date;
}

#pragma mark: --- action
-(void)cancelBtnCLick:(UIButton *)btn{
//    [AppConfigs showAlertWithTitle:@"提示" msg:@"否是放弃编辑？" confirm:^{
//        [self dissmissVC];
//    }];
    [self dissmissVC];
}

-(void)confirmBtnCLick:(UIButton *)btn{
    if (self.titleTF.text.length == 0) {
        [ZJToastManager showErrorToastWithMsg:@"What do you want do?😊"];
        return;
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if (self.model.Id.length == 0) {
        RLMResults *resArr = [TodoModel allObjects];
        self.model.Id = [NSString stringWithFormat:@"%ld", resArr.count];
    }
    self.model.title = self.titleTF.text;
    self.model.date = self.oldDate;
    self.model.year = self.oldDate.year;
    self.model.mounth = self.oldDate.month;
    self.model.day = self.oldDate.day;
    self.model.nthWeekday = self.oldDate.nthWeekday;
    self.model.weedDay = [self.weedDayArray[self.oldDate.weekday] integerValue];
    [realm addOrUpdateObject:self.model];
    [realm commitWriteTransaction];
    if (self.didFinishedAddAndEdit) {
        self.didFinishedAddAndEdit(self.model);
    }
    [self dissmissVC];
}

-(void)dissmissVC{
    [self.titleTF resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self dismissViewControllerAnimated:true completion:nil];
    });
}


#pragma mark: --- QMUITextViewDelegate
- (void)textView:(QMUITextView *)textView newHeightAfterTextChanged:(CGFloat)height{
    self.titleTV.heightSize.equalTo(@(height));
}

#pragma mark: --- 监听DatePicker滚动
- (void)dateChange:(UIDatePicker *)datePicker {
    self.oldDate = datePicker.date;
}


#pragma mark: --- lazy
-(MyRelativeLayout *)rootLayout{
    if (!_rootLayout) {
        _rootLayout = [[MyRelativeLayout alloc] init];
        _rootLayout.myLeft = 0;
        _rootLayout.myTop = 0;
        _rootLayout.myWidth = SCREEN_W;
        _rootLayout.myHeight = SCREEN_H;
    }
    return _rootLayout;
}

-(QMUIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[QMUIButton alloc] init];
        _cancelBtn.leftPos.equalTo(@0);
        _cancelBtn.topPos.equalTo(@0);
        _cancelBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 10, 10);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[ColorManager colorWithLightColorStr:@"#9370DB" DarkColor:@"#9370DB"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_cancelBtn sizeToFit];
        [_cancelBtn addTarget:self action:@selector(cancelBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(QMUIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[QMUIButton alloc] init];
        _confirmBtn.rightPos.equalTo(@0);
        _confirmBtn.topPos.equalTo(@0);
        _confirmBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 10, 10);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[ColorManager colorWithLightColorStr:@"#9370DB" DarkColor:@"#9370DB"] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_confirmBtn sizeToFit];
        [_confirmBtn addTarget:self action:@selector(confirmBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

-(QMUITextView *)titleTF{
    if (!_titleTV) {
        _titleTV = [[QMUITextView alloc] init];
        _titleTV.leftPos.equalTo(@25);
        _titleTV.rightPos.equalTo(@25);
        _titleTV.topPos.equalTo(@45);
        _titleTV.wrapContentHeight = YES;
        _titleTV.heightSize.min(45);
        _titleTV.placeholder = @"What do you want do?";
        _titleTV.placeholderColor = [ColorManager colorWithLightColorStr:@"#f4f4f4" DarkColor:@"#9370DB"];
        _titleTV.font = [UIFont boldSystemFontOfSize:18];
        _titleTV.returnKeyType = UIReturnKeyDone;
        _titleTV.delegate = self;
        _titleTV.text = self.model.title;
    }
    return _titleTV;
}

-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.topPos.equalTo(self.titleTF.bottomPos);
        _datePicker.centerXPos.equalTo(self.rootLayout);
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [_datePicker setDate:self.model.date animated:YES];
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}


@end
