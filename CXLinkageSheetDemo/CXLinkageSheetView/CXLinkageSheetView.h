//
//  CXLinkageSheetView.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathResponseTableView : UITableView

@property (nonatomic, strong) UIBezierPath *path;

@end


@protocol CXLinkageSheetViewDataSource <NSObject>

@optional



/**
 SheetView 每个section的样式

 @param section 第几个section
 @return section的视图样式
 */
- (UIView *)viewForSheetViewHeaderInSection:(NSInteger)section;

/**
 SheetView 每个section的高度

 @param section 第几个section
 @return section的高度
 */
- (CGFloat)heightForSheetViewHeaderInSection:(NSInteger)section;

/**
 SheetView 的section个数
 
 @return section section数
 */
- (NSInteger)numberOfSectionsInSheetView;


/**
 SheetView 每个section的行数

 @param section 具体某一个section
 @return 行数
 */
- (NSInteger)numberOfRowsInSheetViewSection:(NSInteger)section;


/**
 SheetView 左侧表格格子内容视图

 @param contentView 左侧格子父视图
 @param indexPath 左侧格子的indexPath
 @return 左侧格子内容视图
 */
- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath;


/**
 SheetView 右侧表格格子内容视图

 @param contentView 右侧格子父视图
 @param indexPath 右侧格子的indexPath
 @param itemIndex 右侧格子的横向Index
 @return 右侧格子内容视图
 */
- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex;


/**
 SheetView 左侧顶部标题栏格子内容视图
 
 @param titleContentView 左侧顶部标题栏格子父视图
 @return 左侧顶部标题栏格子内容视图
 */
- (UIView *)leftTitleView:(UIView *)titleContentView;

/**
 SheetView 右侧顶部标题栏格子内容视图

 @param titleContentView 右侧顶部标题栏格子父视图
 @param index 右侧顶部标题栏index
 @return 右侧顶部标题栏格子内容视图
 */
- (UIView *)rightTitleView:(UIView *)titleContentView index:(NSInteger)index;

@end

@interface CXLinkageSheetView : UIView

@property (nonatomic, weak, nullable) id <CXLinkageSheetViewDataSource> dataSource;


@property (nonatomic, assign) NSInteger leftTableCount;         // 左边表格行数,即纵向行数
@property (nonatomic, assign) NSInteger rightTableCount;        // 右边表格行数,即横向行数,必须要赋值

@property (nonatomic, strong) UIColor *outLineColor;            // 表格外部分割线颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, assign) CGFloat outLineWidth;             // 表格分割线宽度, 默认为 1.0
@property (nonatomic, strong) UIColor *innerLineColor;          // 表格内部格子分割线颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, assign) CGFloat innerLineWidth;           // 表格内部格子分割线宽度, 默认为 1.0
@property (nonatomic, assign) CGFloat sheetHeaderHeight;        // 表格头部高度, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetRowHeight;           // 表格行高, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetLeftTableWidth;      // 表格左侧宽度, 默认为整个表格的 1/3
@property (nonatomic, assign) CGFloat sheetRightTableWidth;     // 表格右侧宽度, 默认为整个表格的 1/3

@property (nonatomic, assign) NSInteger autoMinRightTableCount; // 自动分配表格右侧宽度, 右侧表格会显示该值对应的个数,设置了这个值有会导致 sheetRightTableWidth 失效

@property (nonatomic, assign) BOOL showAllSheetBorder;          // 展示所有格子的分割线
@property (nonatomic, assign) BOOL pagingEnabled;               // 开启右侧表格横向滚动分页效果, 分页距离为 单个格子宽度

- (void)reloadData;

@end
