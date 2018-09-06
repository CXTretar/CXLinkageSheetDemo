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
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.contentView addSubview:self.titleLabel];

    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor lightGrayColor];
    self.rightLine = rightLine;
    [self.contentView addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];;
    self.bottomLine = bottomLine;
    [self.contentView addSubview:bottomLine];
}

//即将布局子控件就会调用这个方法，我们在这里完成cell里面子控件的相对布局
- (void)layoutSubviews {
    //重写这个方法，一定要记得手动调用父类方法。
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.titleLabel.frame = self.bounds;
    self.rightLine.frame = CGRectMake(width - 1, 0, 1, height);
    self.bottomLine.frame = CGRectMake(0, height - 1, width - 1, 1);
    
    
}


@end
