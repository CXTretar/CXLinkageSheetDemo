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
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }

    CGFloat width = self.bounds.size.width / _itemDataArray.count;
    CGFloat height = self.bounds.size.height;
    for (NSInteger i = 0; i < _itemDataArray.count; i ++) {
        CXLinkageSheetRightItem *item = [[CXLinkageSheetRightItem alloc]initWithFrame:CGRectMake(width * i, 0, width, height)];
        item.titleLabel.text = _itemDataArray[i];
        item.titleLabel.font = [UIFont systemFontOfSize:_textFont];
        item.showBorder = _showBorder;
        item.lineColor = _lineColor;
        [self.contentView addSubview:item];
    }
    
}



@end




