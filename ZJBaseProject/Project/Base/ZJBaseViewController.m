//
//  ZJBaseViewController.m
//  ZJBaseProject
//
//  Created by 孑孓 on 2018/5/23.
//  Copyright © 2018年 孑孓. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
}

-(void)config{
    self.view.backgroundColor = [ColorManager colorWithLightColorStr:@"#ffffff" DarkColor:@"#333333"];
    self.hbd_barShadowHidden = YES;
    self.hbd_titleTextAttributes = @{NSForegroundColorAttributeName:[ColorManager colorWithLightColorStr:@"#333333" DarkColor:@"#ffffff"]};
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    self.hbd_barTintColor = [ColorManager colorWithLightColorStr:@"#ffffff" DarkColor:@"#333333"];
}

@end
