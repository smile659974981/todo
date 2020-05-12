//
//  TodoModel.m
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "TodoModel.h"

@implementation TodoModel

+ (NSString *)primaryKey{
    return @"Id";
}

+ (NSArray<NSString *> *)indexedProperties{
    return @[@"Id"];
}

+ (NSDictionary *)defaultPropertyValues{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970] * 1000)];
    return @{@"date":datenow, @"Id":timeSp};
}

@end
