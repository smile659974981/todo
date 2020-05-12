//
//  ZJToastManager.h
//  ZJBaseProject
//
//  Created by silence on 2019/3/16.
//  Copyright © 2019 孑孓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJToastManager : NSObject

+(void)showErrorToastWithMsg:(NSString *)msg;

+(void)showSuccessToastWithMsg:(NSString *)msg;

@end
