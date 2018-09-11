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
    self.lineWidth = 1;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
    CGFloat height = self.bounds.size.height;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _cellWidth, height)];
    [self.contentView addSubview:bgView];
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(_cellWidth - _lineWidth, 0, _lineWidth, height)];
    rightLine.backgroundColor = _lineColor;
    rightLine.hidden = !_showBorder;
    [self.contentView addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - _lineWidth, _cellWidth - _lineWidth, _lineWidth)];
    bottomLine.backgroundColor = _lineColor;
    bottomLine.hidden = !_showBorder;
    [self.contentView addSubview:bottomLine];
    
    if ([_dataSourse respondsToSelector:@selector(createLeftItemWithContentView:indexPath:)]) {
        [self.contentView addSubview:[_dataSourse createLeftItemWithContentView:bgView indexPath:self.indexPath]];
    }

}


@end
