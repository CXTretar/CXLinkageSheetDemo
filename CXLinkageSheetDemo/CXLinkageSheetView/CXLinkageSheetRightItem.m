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

@end

@implementation CXLinkageSheetRightItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        _lineWidth = 1.0f;
    }
    
    return self;
}

- (void)setupUI {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - _lineWidth, 0, _lineWidth, height)];
    rightLine.hidden = YES;
    self.rightLine = rightLine;
    [self addSubview:rightLine];
}

- (void)setShowBorder:(BOOL)showBorder {
    _showBorder = showBorder;
    _rightLine.hidden = !showBorder;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _rightLine.backgroundColor = lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _rightLine.frame = CGRectMake(width - _lineWidth, 0, _lineWidth, height);
}

@end
