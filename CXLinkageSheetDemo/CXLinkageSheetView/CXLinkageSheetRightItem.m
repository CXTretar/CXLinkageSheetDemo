//
//  CXLinkageSheetRightItem.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "CXLinkageSheetRightItem.h"

@interface CXLinkageSheetRightItem ()

@property (nonatomic, weak) UIView *rightLine;
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation CXLinkageSheetRightItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - 1, 0, 1, height)];
    rightLine.hidden = YES;
    self.rightLine = rightLine;
    [self addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, width - 1, 1)];
    bottomLine.hidden = YES;
    self.bottomLine = bottomLine;
    [self addSubview:bottomLine];
    
}

- (void)setShowBorder:(BOOL)showBorder {
    _showBorder = showBorder;
    _rightLine.hidden = !showBorder;
    _bottomLine.hidden = !showBorder;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _rightLine.backgroundColor = lineColor;
    _bottomLine.backgroundColor = lineColor;
}

@end
