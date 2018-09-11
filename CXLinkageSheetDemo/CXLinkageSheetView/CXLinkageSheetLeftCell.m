//
//  CXLinkageSheetLeftCell.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "CXLinkageSheetLeftCell.h"

@interface CXLinkageSheetLeftCell()

@property (nonatomic, weak) UIView *rightLine;
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation CXLinkageSheetLeftCell

- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
   
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - 1, 0, 1, height)];
    rightLine.backgroundColor = _lineColor;
    rightLine.hidden = !_showBorder;
    [self.contentView addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, width - 1, 1)];
    bottomLine.backgroundColor = _lineColor;
    bottomLine.hidden = !_showBorder;
    [self.contentView addSubview:bottomLine];
    
    if ([_dataSourse respondsToSelector:@selector(createLeftItemWithContentView:indexPath:)]) {
        [self.contentView addSubview:[_dataSourse createLeftItemWithContentView:self.contentView indexPath:self.indexPath]];
    }

}


@end
