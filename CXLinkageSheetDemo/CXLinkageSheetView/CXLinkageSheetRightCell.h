//
//  CXLinkageSheetRightCell.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CXLinkageSheetRightCellDataSourse <NSObject>

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex;

@end

@interface CXLinkageSheetRightCell : BaseTableViewCell

@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) BOOL showBorder;

@property (nonatomic, weak) id<CXLinkageSheetRightCellDataSourse> dataSourse;

@end
