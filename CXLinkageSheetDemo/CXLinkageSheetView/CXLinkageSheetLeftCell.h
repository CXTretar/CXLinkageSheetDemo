//
//  CXLinkageSheetLeftCell.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CXLinkageSheetLeftCellDataSourse <NSObject>

- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath;

@end

@interface CXLinkageSheetLeftCell : BaseTableViewCell

@property (nonatomic, weak) id<CXLinkageSheetLeftCellDataSourse> dataSourse;

@property (nonatomic, assign) BOOL showBorder;
@property (nonatomic, strong) UIColor *lineColor;

@end
