//
//  TodoTableViewCell.h
//  ZJBaseProject
//
//  Created by silence on 2020/4/23.
//  Copyright © 2020 孑孓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoModel.h"

@protocol TodoTableViewCellDelegate <NSObject>

-(void)editOrDeleteModel:(TodoModel *)mdoel isEdit:(BOOL)isEdit indexPath:(NSIndexPath *)indexPath;
@end

@interface TodoTableViewCell : UITableViewCell
@property(nonatomic,strong)MyRelativeLayout *rootLayout;
@property(nonatomic,strong)TodoModel *model;
@property(nonatomic,weak)id<TodoTableViewCellDelegate> delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
