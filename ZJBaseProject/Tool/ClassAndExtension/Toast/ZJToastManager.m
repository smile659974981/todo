//
//  ZJToastManager.m
//  ZJBaseProject
//
//  Created by silence on 2019/3/16.
//  Copyright © 2019 孑孓. All rights reserved.
//

#import "ZJToastManager.h"
#import <FFToast/FFToast.h>

@implementation ZJToastManager

+ (void)showErrorToastWithMsg:(NSString *)msg{
    FFToast *toast = [[FFToast alloc] initToastWithTitle:@"提示" message:msg iconImage:nil];
    toast.toastPosition = FFToastPositionBelowStatusBarWithFillet;
    toast.toastType = FFToastTypeWarning;
    toast.duration = 1.0;
    [toast show];
}

+ (void)showSuccessToastWithMsg:(NSString *)msg{
    FFToast *toast = [[FFToast alloc] initToastWithTitle:nil message:msg iconImage:nil];
    toast.toastPosition = FFToastPositionBelowStatusBarWithFillet;
    toast.toastType = FFToastTypeSuccess;
    toast.duration = 1.0;
    [toast show];
}

@end
