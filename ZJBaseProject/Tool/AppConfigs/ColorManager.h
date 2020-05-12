//
//  ColorManager.h
//  ZJBaseProject
//
//  Created by silence on 2019/3/16.
//  Copyright © 2019 孑孓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorManager : NSObject

+(UIColor *)mainColor;
+(UIColor *)viewControllerBackgroundColor;
+(UIColor *)tableViewBackGroundColor;
+(UIColor *)lineColor;
+(UIColor *)normalColor;
+(UIColor *)selectedColor;
+(UIColor *)tintColor;
///适配iOS 13 系统暗黑模式
+(UIColor *)colorWithLightColorStr:(NSString *)lightColor DarkColor:(NSString *)darkColor;

@end
