//
//  CXLinkageSheetRightCell.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "CXLinkageSheetRightCell.h"
#import "CXLinkageSheetRightItem.h"

@interface CXLinkageSheetRightCell ()


@end

@implementation CXLinkageSheetRightCell

- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
    
    CGFloat width = self.bounds.size.width / _itemCount;
    CGFloat height = self.bounds.size.height;
    for (NSInteger i = 0; i < _itemCount; i ++) {
        CXLinkageSheetRightItem *item = [[CXLinkageSheetRightItem alloc]initWithFrame:CGRectMake(width * i, 0, width, height)];
        item.showBorder = _showBorder;
        item.lineColor = _lineColor;
        item.lineWidth = _lineWidth;
        [self.contentView addSubview:item];
        
        if ([_dataSourse respondsToSelector:@selector(createRightItemWithContentView:indexPath:itemIndex:)]) {
            [item addSubview:[_dataSourse createRightItemWithContentView:item indexPath:self.indexPath itemIndex:i]];
        }
    }
}



@end




