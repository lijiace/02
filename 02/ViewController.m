//
//  ViewController.m
//  02
//
//  Created by XW on 2018/2/25.
//  Copyright © 2018年 XW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrys;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, assign) BOOL isSelect;
@end
static  NSString *const cellId = @"cellid";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.isSelect = NO;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:10];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.index == indexPath && self.index != nil && self.isSelect == YES) {
        self.isSelect = NO;
        //        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        //        cell.textLabel.font = [UIFont systemFontOfSize:10];
    } else {
        self.isSelect = YES;
        self.index = indexPath;
        
    }
    [self.tableView reloadData];
    
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSelect) {
        if (self.index.row == indexPath.row && self.index != nil) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:30];
            return 100;
        } else {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:10];
            return 44;
        }
    } else {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        return 44;
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    //
    //    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //    CGRect frame2 = cell.frame;
    //    frame2.size.height -= 30;
    //    [cell setFrame:frame2];
    //    cell.textLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row];
    //    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.tableView rectForRowAtIndexPath:indexPath];
    
}


@end
