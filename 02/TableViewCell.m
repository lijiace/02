
//  TableViewCell.m
//  02
//
//  Created by XW on 2018/2/26.
//  Copyright © 2018年 XW. All rights reserved.
//

#import "TableViewCell.h"
#import "CollectionViewCell.h"
@interface TableViewCell() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;
@property (nonatomic,assign)BOOL isChange;
@property (nonatomic,strong)NSMutableArray *cellAttributesArray;
@end

static NSString *const cellID = @"CollectionViewCell";
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCollectionView];
}

-(void)setCollectionView{
    self.collectionview.frame = CGRectZero;
    self.flowlayout.itemSize = CGSizeMake(50, 20);
    [self.collectionview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.bounces = NO;
    self.collectionview.scrollEnabled = NO;
  
    
   
}

-(void)setModels:(NSMutableArray *)models{
    _models = models;
    [self.collectionview reloadData];
    [self.contentView layoutIfNeeded];
    CGFloat height = self.collectionview.contentSize.height;
    self.collectionViewHeight.constant = height;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString *title = self.models[indexPath.item];
    [cell.btn setTitle:title forState:UIControlStateNormal];
    cell.itemBlock = ^(NSString *name) {
        if (self.itemBlock) {
            self.itemBlock(name);
        }
    };
    //为每个cell 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    return cell;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    CollectionViewCell *cell = (CollectionViewCell *)longPress.view;
    NSIndexPath *cellIndexpath = [self.collectionview indexPathForCell:cell];
    
    [self.collectionview  bringSubviewToFront:cell];
    
    _isChange = NO;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.models.count; i++) {
                [self.cellAttributesArray addObject:[self.collectionview layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            cell.center = [longPress locationInView:self.collectionview];
            
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    NSString *imgStr = self.models[cellIndexpath.row];
                    [self.models removeObjectAtIndex:cellIndexpath.row];
                    [self.models insertObject:imgStr atIndex:attributes.indexPath.row];
                    [self.collectionview moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                }
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            if (!_isChange) {
                cell.center = [self.collectionview layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
        }
            
            break;
            
        default:
            break;
    }
    
}

   
- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}


@end
