//
//  CXLinkageSheetRightCell.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CXLinkageSheetRightCell : BaseTableViewCell

@property (nonatomic, strong) NSArray *itemDataArray;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) NSInteger textFont;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) BOOL showBorder;

@end
