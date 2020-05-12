//
//  AppConfigs.h
//  ZJBaseProject
//
//  Created by 孑孓 on 2018/5/23.
//  Copyright © 2018年 孑孓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^AlertConfirmBlock)(void);
typedef void(^SheetConfirmBlock)(int index);

@interface AppConfigs : NSObject

///获取当前控制器
+(UIViewController *)getCurrentVC;

///弹窗（alert）
+(void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg
                                            confirm:(AlertConfirmBlock)confirm;

///弹窗（sheet）
+(void)showSheetWithTitle:(NSString *)title msg:(NSString *)msg buttons:(NSArray *)buttons :(void(^)(int index))selected;


///获取当前用户是否为暗黑模式
+(BOOL)isDarkStyle;

@end
