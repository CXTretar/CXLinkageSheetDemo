//
//  CXLinkageSheetRightCell.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CXLinkageSheetRightCellDataSourse <NSObject>

- (UIView *_Nullable)createRightItemWithContentView:(UIView *_Nullable)contentView indexPath:(NSIndexPath *_Nullable)indexPath itemIndex:(NSInteger)itemIndex;

@end

@protocol CXLinkageSheetRightCellDelegate <NSObject>

- (void)didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath andItemIndex:(NSInteger )itemIndex;

@end

@interface CXLinkageSheetRightCell : BaseTableViewCell

@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIColor * _Nullable lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) BOOL showBorder;

@property (nonatomic, weak) id<CXLinkageSheetRightCellDataSourse> _Nullable dataSourse;
@property (nonatomic, weak) id<CXLinkageSheetRightCellDelegate> _Nullable delegate;

@end
