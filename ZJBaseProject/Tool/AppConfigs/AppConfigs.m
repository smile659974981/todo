//
//  AppConfigs.m
//  ZJBaseProject
//
//  Created by 孑孓 on 2018/5/23.
//  Copyright © 2018年 孑孓. All rights reserved.
//

#import "AppConfigs.h"

@implementation AppConfigs

//获取当前VC
+(UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+(UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}


//弹窗（alert）
+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg confirm:(AlertConfirmBlock)confirm{
    QMUIAlertController *alertController = [[QMUIAlertController alloc] initWithTitle:title message:msg preferredStyle:QMUIAlertControllerStyleAlert];
    alertController.sheetTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor qmui_colorWithHexString:@"#FF8E07"]};
    alertController.alertSeparatorColor = [UIColor qmui_colorWithHexString:@"#CCCCCC"];
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        confirm();
    }];
    action1.buttonAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor redColor]};
    QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    [alertController addAction:action1];
    [alertController addAction:action3];
    [alertController showWithAnimated:YES];
}

//弹窗（sheet）
+ (void)showSheetWithTitle:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons :(void (^)(int))selected{
    QMUIAlertController *alertController = [[QMUIAlertController alloc] initWithTitle:nil message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
    alertController.title = title;
    alertController.message = msg;
    for (int i = 0; i < buttons.count; i ++) {
        QMUIAlertAction *action = [QMUIAlertAction actionWithTitle:buttons[i] style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            selected(i);
        }];
        if ([buttons[i] isEqualToString:@"确定退出登录？"]) {
            action.buttonAttributes = @{NSForegroundColorAttributeName : [UIColor qmui_colorWithHexString:@"FF0000"]};
        }
        [alertController addAction:action];
    }
    QMUIAlertAction *cancelAction = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
    [alertController addAction:cancelAction];
    [alertController showWithAnimated:YES];
}

+ (BOOL)isDarkStyle{
    if (@available(iOS 13, *)) {
        return UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark? YES : NO;
    }
    return NO;
}
@end
