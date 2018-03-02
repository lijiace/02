//
//  CollectionViewCell.m
//  02
//
//  Created by XW on 2018/2/26.
//  Copyright © 2018年 XW. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (IBAction)btnClick:(UIButton *)sender {
    if (self.itemBlock) {
        self.itemBlock(sender.titleLabel.text);
        
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
