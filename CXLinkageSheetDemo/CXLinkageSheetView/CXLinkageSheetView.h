//
//  CXLinkageSheetView.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathResponseView : UIView

@property (nonatomic, strong) UIBezierPath * _Nullable path;

@end

@protocol CXLinkageSheetViewDelegate <NSObject>

@optional

/// 左侧表格点击事件
/// @param tableView 左侧tableView
/// @param indexPath 点击的indexPath

- (void)leftTableView:(UITableView *_Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;


/// 右侧侧表格点击事件
/// @param tableView 右侧tableView
/// @param indexPath 点击的那一行的indexPath
/// @param itemIndex 点击的那一行的从左往右的具体位置

- (void)rightTableView:(UITableView *_Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath andItemIndex:(NSInteger )itemIndex;

@end

@protocol CXLinkageSheetViewDataSource <NSObject>

@optional

/**
 SheetView 每个section的样式
 
 @param section 第几个section
 @return section的视图样式
 */
- (UIView *_Nullable)viewForSheetViewHeaderInSection:(NSInteger)section;

/**
 SheetView 每个section的高度
 
 @param section 第几个section
 @return section的高度
 */
- (CGFloat)heightForSheetViewHeaderInSection:(NSInteger)section;


- (CGFloat)heightForSheetViewForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;

- (CGFloat)rightTableViewCellWidthForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath andItemIndex:(NSInteger )itemIndex;

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
- (UIView *_Nullable)createLeftItemWithContentView:(UIView *_Nullable)contentView indexPath:(NSIndexPath *_Nullable)indexPath;


/**
 SheetView 右侧表格格子内容视图
 
 @param contentView 右侧格子父视图
 @param indexPath 右侧格子的indexPath
 @param itemIndex 右侧格子的横向Index
 @return 右侧格子内容视图
 */
- (UIView *_Nullable)createRightItemWithContentView:(UIView *_Nullable)contentView indexPath:(NSIndexPath *_Nullable)indexPath itemIndex:(NSInteger)itemIndex;


/**
 SheetView 左侧顶部标题栏格子内容视图
 
 @param titleContentView 左侧顶部标题栏格子父视图
 @return 左侧顶部标题栏格子内容视图
 */
- (UIView *_Nullable)leftTitleView:(UIView *_Nullable)titleContentView;

/**
 SheetView 右侧顶部标题栏格子内容视图
 
 @param titleContentView 右侧顶部标题栏格子父视图
 @param index 右侧顶部标题栏index
 @return 右侧顶部标题栏格子内容视图
 */
- (UIView *_Nullable)rightTitleView:(UIView *_Nullable)titleContentView index:(NSInteger)index;


@end

@interface CXLinkageSheetView : UIView

@property (nonatomic, weak, nullable) id <CXLinkageSheetViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <CXLinkageSheetViewDataSource> dataSource;

@property (nonatomic, assign) NSInteger leftTableCount;         // 左边表格行数,即纵向行数
@property (nonatomic, assign) NSInteger rightTableCount;        // 右边表格行数,即横向行数,必须要赋值

@property (nonatomic, strong) UIColor * _Nullable outLineColor; // 表格外部分割线颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, assign) CGFloat outLineWidth;             // 表格分割线宽度, 默认为 1.0
@property (nonatomic, strong) UIColor * _Nullable innerLineColor;  // 表格内部格子分割线颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, assign) CGFloat innerLineWidth;           // 表格内部格子分割线宽度, 默认为 1.0
@property (nonatomic, assign) CGFloat sheetHeaderHeight;        // 表格头部高度, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetRowHeight;           // 表格行高, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetLeftTableWidth;      // 表格左侧宽度, 默认为整个表格的 1/3
@property (nonatomic, assign) CGFloat sheetRightTableWidth;     // 表格右侧宽度, 默认为整个表格的 1/3

@property (nonatomic, assign) NSInteger autoMinRightTableCount; // 自动分配表格右侧宽度, 右侧表格会显示该值对应的个数,设置了这个值有会导致 sheetRightTableWidth 失效

@property (nonatomic, assign) BOOL showAllSheetBorder;          // 展示所有格子的分割线
@property (nonatomic, assign) BOOL pagingEnabled;               // 开启右侧表格横向滚动分页效果, 分页距离为 单个格子宽度
@property (nonatomic, assign) BOOL bounceEnabled;               // 开启右侧表格横向滚动弹性效果
@property (nonatomic, assign) BOOL showShadowBorder;            // 开启右侧表格横向滚动时,左侧表格边界阴影效果
@property (nonatomic, assign) BOOL showsVerticalScrollIndicator;// 开启右侧表格垂直滚动指示器

- (void)reloadData;

@end
