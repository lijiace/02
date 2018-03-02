
//
//  MainViewController.m
//  02
//
//  Created by XW on 2018/2/26.
//  Copyright © 2018年 XW. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewCell.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrys;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *addModels;
@end

static NSString *const cellID = @"TableViewCell";
@implementation MainViewController
-(NSMutableArray *)addModels{
    if (!_addModels) {
        _addModels = [NSMutableArray array];
    }
    return _addModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrys = @[@[@"钢琴",@"吉他",@"1",@"2",@"3",@"4",@"钢琴",@"吉他"],@[@"街舞",@"拉丁武",@"5",@"6",@"7",@"8",@"街舞",@"拉丁武"]];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.estimatedRowHeight = 440;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
//    int array[5] = {1, 6, 3, 4, 5};
//    int *p = &array[0];
//    int max = MAX(++(*p), 1);
//    printf("%d %d", max, *p);
    
    int a = 10;
    void (^block)() = ^{
        NSLog(@"a is %d", a);
    };
    a = 20;
   
    block(); // 10
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"以选兴趣";
    } else if (section == 1){
        return @"乐器";
    } else {
        return @"舞蹈";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (self.titles.count> 0) {
            cell.itemBlock = ^(NSString *name) {
                NSMutableArray *arrys = [NSMutableArray arrayWithArray:self.titles];
                [self.titles enumerateObjectsUsingBlock:^(NSString *oldName, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([name isEqualToString:oldName]) {
                        [arrys removeObject:oldName];
                        [self.addModels removeObject:oldName];
                    }
                }];
                self.titles = arrys.copy;
                if (self.titles.count == 0) {
                    self.titles = nil;
                    self.addModels = nil;
                }
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
            };
        }
        
        cell.models = self.titles.mutableCopy ;
        
    } else if (indexPath.section == 1){
        NSArray *arrys = self.arrys[0];
        cell.models = arrys.mutableCopy;
        [self addnewModels:cell];
    } else {
        NSArray *arrys = self.arrys[1];
        cell.models = arrys.mutableCopy;
        [self addnewModels:cell];
    }
    return cell;
}

-(void)addnewModels:(TableViewCell *)cell{
    cell.itemBlock = ^(NSString *name) {
        [self.addModels addObject:name];
        NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:self.addModels];
        self.titles = [NSArray arrayWithArray:set.array];
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
    };
}


@end
