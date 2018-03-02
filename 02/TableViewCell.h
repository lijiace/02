//
//  TableViewCell.h
//  02
//
//  Created by XW on 2018/2/26.
//  Copyright © 2018年 XW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, copy) void(^itemBlock)(NSString *name);
@end
