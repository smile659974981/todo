//
//  AddViewController.h
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "TodoModel.h"

@interface AddViewController : ZJBaseViewController
@property(nonatomic,strong)TodoModel *model;
@property(nonatomic,copy) void(^didFinishedAddAndEdit)(TodoModel *model);
@end
