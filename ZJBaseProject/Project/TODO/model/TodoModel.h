//
//  TodoModel.h
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "RLMObject.h"

@interface TodoModel : RLMObject

///
@property(nonatomic,strong)NSString *Id;
///
@property(nonatomic,strong)NSString *title;
///
//@property(nonatomic,strong)NSString *content;
///
@property(nonatomic,strong)NSDate *date;
///
@property(nonatomic,assign)BOOL isFinished;
///
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger mounth;
@property(nonatomic,assign)NSInteger day;
@property(nonatomic,assign)NSInteger weedDay;
@property(nonatomic,assign)NSInteger nthWeekday;

@end
