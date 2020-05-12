//
//  TodoHeaderView.m
//  ZJBaseProject
//
//  Created by silence on 2020/4/28.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "TodoHeaderView.h"
#import "NSDate+Utilities.h"

@interface TodoHeaderView()
@property(nonatomic,strong)MyRelativeLayout *rootLayout;
@property(nonatomic,strong)QMUILabel *titleLa;
@end

@implementation TodoHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.rootLayout = [[MyRelativeLayout alloc] init];
        self.rootLayout.myLeft = 0;
        self.rootLayout.myTop = 0;
        self.rootLayout.myWidth = SCREEN_W;
        self.rootLayout.myBottom = 0;
        self.rootLayout.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.rootLayout];
        
        self.titleLa = [[QMUILabel alloc] init];
        self.titleLa.leftPos.equalTo(@15);
        self.titleLa.bottomPos.equalTo(@5);
        self.titleLa.heightSize.equalTo(@30);
        self.titleLa.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        self.titleLa.wrapContentWidth = YES;
        self.titleLa.textColor = [UIColor qmui_colorWithHexString:@"#ffffff"];
        self.titleLa.font = [UIFont boldSystemFontOfSize:20];
        self.titleLa.backgroundColor = [UIColor qmui_colorWithHexString:@"#20B2AA"];
        self.titleLa.layer.cornerRadius = 14;
        self.titleLa.layer.masksToBounds = YES;
        [self.rootLayout addSubview:self.titleLa];
    }
    return self;
}

- (void)setModel:(TodoModel *)model{
    _model = model;
    if (model.date.isThisYear) {
        self.titleLa.text = @"今年";
    }else{
        self.titleLa.text = [NSString stringWithFormat:@"%ld", model.year];
    }
}
@end
