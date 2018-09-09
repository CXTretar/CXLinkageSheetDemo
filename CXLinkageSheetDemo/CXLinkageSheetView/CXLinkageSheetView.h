//
//  CXLinkageSheetView.h
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXLinkageSheetViewDataSource <NSObject>

- (UITableViewCell *)leftTableView:(UITableView *)leftTableView rightTableView:(UITableView *)rightTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)rightTitleView:(UIView *)titleContentView index:(NSInteger)index;

@end

@protocol CXLinkageSheetViewDelegate <NSObject>

@end

@interface CXLinkageSheetView : UIView

@property (nonatomic, weak, nullable) id <CXLinkageSheetViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <CXLinkageSheetViewDelegate> delegate;


@property (nonatomic, strong) NSArray <NSString *>*leftTitleArray;
@property (nonatomic, strong) NSArray <NSString *>*rightTitleArray;
@property (nonatomic, strong) NSArray <NSArray *>*rightDetailArray;

@property (nonatomic, strong) UIColor *sheetLineColor;
@property (nonatomic, assign) NSInteger sheetRightTitleFont;
@property (nonatomic, assign) NSInteger sheetLeftTitleFont;
@property (nonatomic, assign) CGFloat sheetHeaderHeight;
@property (nonatomic, assign) CGFloat sheetRowHeight;
@property (nonatomic, assign) CGFloat sheetLeftTableWidth;
@property (nonatomic, assign) CGFloat sheetRightTableWidth;

@property (nonatomic, assign) NSInteger autoMinRightTableCount;


@property (nonatomic, assign) BOOL showAllSheetBorder;
@property (nonatomic, assign) BOOL pagingEnabled;

- (void)reloadData;

@end
