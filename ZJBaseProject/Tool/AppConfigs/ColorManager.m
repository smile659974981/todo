//
//  ColorManager.m
//  ZJBaseProject
//
//  Created by silence on 2019/3/16.
//  Copyright © 2019 孑孓. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

+ (UIColor *)mainColor{
    return [UIColor qmui_colorWithHexString:@"#E33030"];
}

+ (UIColor *)viewControllerBackgroundColor{
    return [UIColor qmui_colorWithHexString:@"#f4f4f4"];
}

+ (UIColor *)tableViewBackGroundColor{
    return [UIColor qmui_colorWithHexString:@"#f4f4f4"];
}

+ (UIColor *)lineColor{
    return [UIColor qmui_colorWithHexString:@"#f4f4f4"];
}

+ (UIColor *)normalColor{
    return [UIColor qmui_colorWithHexString:@"#444444"];
}

+ (UIColor *)selectedColor{
    return [UIColor qmui_colorWithHexString:@"#E33030"];
}

+ (UIColor *)tintColor{
    return [UIColor qmui_colorWithHexString:@"#444444"];
}

+ (UIColor *)colorWithLightColorStr:(NSString *)lightColor DarkColor:(NSString *)darkColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor qmui_colorWithHexString:lightColor];
            }else{
                return [UIColor qmui_colorWithHexString:darkColor];
            }
        }];
    }else{
        return [UIColor qmui_colorWithHexString:lightColor];
    }
}

@end
