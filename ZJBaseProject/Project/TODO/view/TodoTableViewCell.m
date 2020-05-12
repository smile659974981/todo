//
//  TodoTableViewCell.m
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "TodoTableViewCell.h"
#import "NSDate+Utilities.h"
#import "Realm.h"

@interface TodoTableViewCell()
@property(nonatomic,strong)MyRelativeLayout *subLayout;
@property(nonatomic,strong)MyRelativeLayout *buttonLayout;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UILabel *titleLa;
@property(nonatomic,strong)UILabel *contentLa;
@property(nonatomic,strong)UIImageView *clockImgView;
@property(nonatomic,strong)QMUILabel *dateLa;
@property(nonatomic,strong)QMUIButton *isFinishedBtn;
@property(nonatomic,strong)QMUIButton *editBtn;
@property(nonatomic,strong)QMUIButton *deleteBtn;
@property(nonatomic,strong)NSArray *weekArray;
@property(nonatomic,strong)UIView *coverView;

@end

@implementation TodoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [ColorManager colorWithLightColorStr:@"#ffffff" DarkColor:@"#333333"];

        self.rootLayout = [[MyRelativeLayout alloc] init];
        self.rootLayout.myLeft = 15;
        self.rootLayout.myWidth = SCREEN_W - 30;
        self.rootLayout.myTop = 10;
        self.rootLayout.wrapContentHeight = YES;
        self.rootLayout.layer.cornerRadius = 8;
        self.rootLayout.layer.masksToBounds = YES;
        [self addSubview:self.rootLayout];

        self.subLayout = [[MyRelativeLayout alloc] init];
        self.subLayout.leftPos.equalTo(@0);
        self.subLayout.widthSize.equalTo(@(SCREEN_W - 30));
        self.subLayout.topPos.equalTo(@0);
        self.subLayout.wrapContentHeight = YES;
        self.subLayout.bottomPadding = 5;
        self.subLayout.layer.cornerRadius = 8;
        self.subLayout.layer.masksToBounds = YES;
        [self.rootLayout addSubview:self.subLayout];

        self.titleView = [[UIView alloc] init];
        self.titleView.leftPos.equalTo(@0);
        self.titleView.topPos.equalTo(@0);
        self.titleView.bottomPos.equalTo(@(-5));
        self.titleView.widthSize.equalTo(@10);
        self.titleView.backgroundColor = [ColorManager colorWithLightColorStr:@"#9370DB" DarkColor:@"#9370DB"];
        [self.subLayout addSubview:self.titleView];
        
        self.isFinishedBtn = [[QMUIButton alloc] init];
        self.isFinishedBtn.rightPos.equalTo(@15);
        self.isFinishedBtn.centerYPos.equalTo(self.subLayout);
        self.isFinishedBtn.heightSize.equalTo(@25);
        self.isFinishedBtn.widthSize.equalTo(@25);
        [self.isFinishedBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        [self.isFinishedBtn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [self.subLayout addSubview:self.isFinishedBtn];
        [self.isFinishedBtn addTarget:self action:@selector(finishedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLa = [[UILabel alloc] init];
        self.titleLa.textColor = [ColorManager colorWithLightColorStr:@"#000000" DarkColor:@"#ffffff"];
        self.titleLa.font = [UIFont boldSystemFontOfSize:18];;
        self.titleLa.leftPos.equalTo(self.titleView.rightPos).offset(10);
        self.titleLa.rightPos.equalTo(self.isFinishedBtn.leftPos).offset(15);
        self.titleLa.topPos.equalTo(@10);
        self.titleLa.wrapContentHeight = YES;
        self.titleLa.text = @"标题";
        [self.subLayout addSubview:self.titleLa];
        
        self.clockImgView = [[UIImageView alloc] init];
        self.clockImgView.leftPos.equalTo(self.titleLa.leftPos);
        self.clockImgView.topPos.equalTo(self.titleLa.bottomPos).offset(8);
        self.clockImgView.widthSize.equalTo(@15);
        self.clockImgView.heightSize.equalTo(@15);
        self.clockImgView.image = [UIImage imageNamed:@"clock (1)"];
        [self.subLayout addSubview:self.clockImgView];
        
        self.dateLa = [[QMUILabel alloc] init];
        self.dateLa.textColor = [ColorManager colorWithLightColorStr:@"#606060" DarkColor:@"#959595"];
        self.dateLa.font = [UIFont systemFontOfSize:14];;
        self.dateLa.leftPos.equalTo(self.clockImgView.rightPos).offset(5);
        self.dateLa.rightPos.equalTo(self.titleLa.rightPos);
        self.dateLa.centerYPos.equalTo(self.clockImgView);
        self.dateLa.wrapContentHeight = YES;
        self.dateLa.text = @"2020/04/23";
        [self.subLayout addSubview:self.dateLa];
        
        [self.subLayout layoutIfNeeded];

        self.buttonLayout = [[MyRelativeLayout alloc] init];
        self.buttonLayout.rightPos.equalTo(@0);
        self.buttonLayout.wrapContentHeight = YES;
        self.buttonLayout.widthSize.equalTo(@0);
        self.buttonLayout.centerYPos.equalTo(self.rootLayout);
        self.buttonLayout.layer.masksToBounds = YES;
        self.buttonLayout.backgroundColor = [ColorManager colorWithLightColorStr:@"#ffffff" DarkColor:@"#333333"];
        [self.rootLayout addSubview:self.buttonLayout];
        
        self.deleteBtn = [[QMUIButton alloc] init];
        self.deleteBtn.topPos.equalTo(@0);
        self.deleteBtn.rightPos.equalTo(@0);
        self.deleteBtn.widthSize.equalTo(self.subLayout.heightSize);
        self.deleteBtn.heightSize.equalTo(self.subLayout.heightSize);
        self.deleteBtn.backgroundColor = [ColorManager colorWithLightColorStr:@"#FF4500" DarkColor:@"#FF4500"];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.buttonLayout addSubview:self.deleteBtn];
        self.deleteBtn.layer.cornerRadius = 8;
        self.deleteBtn.layer.masksToBounds = YES;
        [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.editBtn = [[QMUIButton alloc] init];
        self.editBtn.topPos.equalTo(@0);
        self.editBtn.rightPos.equalTo(self.deleteBtn.leftPos).offset(5);
        self.editBtn.widthSize.equalTo(self.subLayout.heightSize);
        self.editBtn.heightSize.equalTo(self.subLayout.heightSize);
        self.editBtn.backgroundColor = [ColorManager colorWithLightColorStr:@"#008B8B" DarkColor:@"#008B8B"];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.buttonLayout addSubview:self.editBtn];
        self.editBtn.layer.cornerRadius = 8;
        self.editBtn.layer.masksToBounds = YES;
        [self.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.weekArray = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
        self.coverView = [[UIView alloc] init];
        self.coverView.leftPos.equalTo(@0);
        self.coverView.rightPos.equalTo(@0);
        self.coverView.topPos.equalTo(@0);
        self.coverView.heightSize.equalTo(@0.01);
        self.coverView.backgroundColor = [UIColor whiteColor];
        self.coverView.alpha = 0;
        [self.rootLayout addSubview:self.coverView];
        
    }
    return self;
}

#pragma mark: --- action
-(void)finishedBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.model.isFinished = btn.isSelected;
    [realm addOrUpdateObject:self.model];
    [realm commitWriteTransaction];
    
    CGFloat scaleValue = btn.isSelected? 1.05 : 0.95;
    [UIView animateWithDuration:0.25 animations:^{
        self.subLayout.backgroundColor = btn.isSelected? [ColorManager colorWithLightColorStr:@"#20B2AA" DarkColor:@"#20B2AA"] : [ColorManager colorWithLightColorStr:@"#f9f9f9" DarkColor:@"#232323"];
        self.rootLayout.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.rootLayout.transform = CGAffineTransformIdentity;
        }];
    }];
}


- (void)setModel:(TodoModel *)model{
    _model = model;
    self.titleLa.text = model.title;
    self.isFinishedBtn.selected = model.isFinished;
    self.titleLa.numberOfLines = 1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/d";
    NSString *dateStr = [formatter  stringFromDate:model.date];
    if (model.date.isThisWeek) {
        if ([model.date isToday]) {
            self.dateLa.text = @"今天";
        }else if ([model.date isTomorrow]){
            self.dateLa.text = @"明天";
        }else if ([model.date isYesterday]){
            self.dateLa.text = @"昨天";
        }else{
            self.dateLa.text = self.weekArray[model.weedDay];
        }
    }else{
        self.dateLa.text = dateStr;
    }
    self.subLayout.backgroundColor = model.isFinished? [ColorManager colorWithLightColorStr:@"#20B2AA" DarkColor:@"#20B2AA"] : [ColorManager colorWithLightColorStr:@"#f9f9f9" DarkColor:@"#232323"];
}

#pragma mark: --- action
-(void)editBtnClick:(UIButton *)btn{
    [self.delegate editOrDeleteModel:self.model isEdit:YES indexPath:self.indexPath];
}

-(void)deleteBtnClick:(UIButton *)btn{
    [AppConfigs showAlertWithTitle:@"提示" msg:@"是否删除该条TODO?" confirm:^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        TodoModel *res = [TodoModel objectInRealm:realm forPrimaryKey:self.model.Id];
        [realm transactionWithBlock:^{
            [realm deleteObject:res];
        }];
        self.editing = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    self.coverView.heightSize.equalTo(self.rootLayout.heightSize);
                    self.coverView.alpha = 0.75;
                    [self.rootLayout layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [self.delegate editOrDeleteModel:self.model isEdit:NO indexPath:self.indexPath];
                }];
        });
    }];
}

- (void)setEditing:(BOOL)editing{
    if (editing) {
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.buttonLayout.widthSize.equalTo(@(2 * (self.subLayout.frame.size.height) + 5));
            self.subLayout.widthSize.equalTo(@(SCREEN_W - 30 - ((2 * (self.subLayout.frame.size.height) + 10))));
            [self.rootLayout layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.35 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.buttonLayout.widthSize.equalTo(@0);
            self.subLayout.widthSize.equalTo(@(SCREEN_W - 30));
            [self.rootLayout layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
