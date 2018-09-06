//
//  CXLinkageSheetView.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "CXLinkageSheetView.h"
#import "CXLinkageSheetLeftCell.h"
#import "CXLinkageSheetRightCell.h"

/* 屏幕的尺寸 */
#define CXScreenWidth  [UIScreen mainScreen].bounds.size.width
#define CXScreenHeight [UIScreen mainScreen].bounds.size.height
#define rgba(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface CXLinkageSheetView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;     // 左侧标题TableView
@property (nonatomic, strong) UITableView *rightTableView;    // 右侧内容TableView
@property (nonatomic, strong) UIScrollView *rightContentView; // 右侧底部内容容器

@property (nonatomic, assign) CGFloat contentSizeWidth;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@implementation CXLinkageSheetView

- (CGFloat)width {
    return self.bounds.size.width;
}

- (CGFloat)height {
    return self.bounds.size.height;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.rightTitleArray = @[].copy;
        self.leftTitleArray = @[].copy;
        self.sheetLineColor = [UIColor lightGrayColor];
        self.sheetHeaderHeight = 40.f;
        self.sheetRowHeight = 40.f;
        self.sheetLeftTableWidth = self.width / 3.0;
        self.sheetRightTableWidth = self.width / 3.0;
        self.sheetRightTitleFont = 12;
        self.sheetLeftTitleFont = 12;
        [self setupUI];
    }
    return self;
}

#pragma mark - 刷新视图UI以及数据源

- (void)reloadData {
    self.sheetLineColor = [UIColor lightGrayColor];
    if (self.autoMinRightTableCount != 0) {

        self.sheetRightTableWidth = (self.width - _sheetLeftTableWidth) / _autoMinRightTableCount;

    }
    
    if ((self.width - _sheetLeftTableWidth) > self.rightTitleArray.count * self.sheetRightTableWidth) {
        self.sheetRightTableWidth = (self.width - _sheetLeftTableWidth) / self.rightTitleArray.count;
    }
    
    self.contentSizeWidth = _sheetRightTableWidth * _rightTitleArray.count;
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    [self setupUI];
}

#pragma mark - 创建视图控件

- (void)setupUI {
    
    self.rightContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(_sheetLeftTableWidth, 0, self.width - _sheetLeftTableWidth, self.height)];
    _rightContentView.delegate = self;
    _rightContentView.showsVerticalScrollIndicator = NO;
    _rightContentView.showsHorizontalScrollIndicator = NO;
    _rightContentView.contentSize = CGSizeMake(_contentSizeWidth, self.height);
    _rightContentView.bounces = NO;
    [self addSubview:_rightContentView];
    
    UIView *titleLabel = [self createTitleViewWithLeft:0 width:_sheetLeftTableWidth height:_sheetHeaderHeight title:@"" index:-1];
    [self addSubview:titleLabel];
    
    for (int i = 0; i < self.rightTitleArray.count; i++) {
        CGFloat x = i * _sheetRightTableWidth;
        UIView *titleView = [self createTitleViewWithLeft:x width:_sheetRightTableWidth height:_sheetHeaderHeight title:self.rightTitleArray[i] index:i];
        [_rightContentView addSubview:titleView];
    }
    [self configTableView];
    
    if (_showAllSheetBorder) {
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.height)];
        leftLine.backgroundColor = _sheetLineColor;
        [self addSubview:leftLine];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.width - 1, 0, 1, self.height)];
        rightLine.backgroundColor = _sheetLineColor;
        [self addSubview:rightLine];
        
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
        upLine.backgroundColor = _sheetLineColor;
        [self addSubview:upLine];
        
        if (self.height < (_sheetRowHeight * self.leftTitleArray.count + _sheetHeaderHeight)) {
            UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
            bottomLine.backgroundColor = _sheetLineColor;
            [self addSubview:bottomLine];
        }
    }
}

- (void)configTableView {
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sheetHeaderHeight, _sheetLeftTableWidth, self.height - _sheetHeaderHeight) style:UITableViewStylePlain];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.bounces = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.showsHorizontalScrollIndicator = NO;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_leftTableView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sheetHeaderHeight, _contentSizeWidth, self.height - _sheetHeaderHeight) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.bounces = NO;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.showsHorizontalScrollIndicator = NO;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.backgroundColor = [UIColor clearColor];
    [_rightContentView addSubview:_rightTableView];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftTitleArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTableView) {
        if ([_dataSource respondsToSelector:@selector(leftTableView:rightTableView:cellForRowAtIndexPath:)]) {
            return [_dataSource leftTableView:_leftTableView rightTableView:nil cellForRowAtIndexPath:indexPath];
        }else {
            CXLinkageSheetLeftCell *cell = [CXLinkageSheetLeftCell createCellWithTableView:tableView];
            cell.titleLabel.text = self.leftTitleArray[indexPath.row];
            cell.titleLabel.font = [UIFont systemFontOfSize:_sheetLeftTitleFont];
            return cell;
            
        }
        
    } else {
        
        
        CXLinkageSheetRightCell *cell = [CXLinkageSheetRightCell createCellWithTableView:tableView];
        cell.itemWidth = _sheetRightTableWidth;
        cell.itemHeight = _sheetRowHeight;
        cell.textFont = _sheetRightTitleFont;
        cell.lineColor = _sheetLineColor;
        cell.showBorder = _showAllSheetBorder;
        cell.itemDataArray = self.rightDetailArray[indexPath.row];
    
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _sheetRowHeight;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _leftTableView) {
        [_rightTableView setContentOffset:CGPointMake(_rightTableView.contentOffset.x, _leftTableView.contentOffset.y)];
    }
    if (scrollView == _rightTableView) {
        [_leftTableView setContentOffset:CGPointMake(0, _rightTableView.contentOffset.y)];
    }
}

#pragma mark - 快速创建顶部标题栏视图

- (UIView *)createTitleViewWithLeft:(CGFloat)left width:(CGFloat)width height:(CGFloat)height title:(NSString *)title index:(NSInteger)index {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(left, 0, width, height)];

    if (title.length) {
        
        if ([_dataSource respondsToSelector:@selector(rightTitleView:index:)]) {
            
            [_dataSource rightTitleView:bgView index:index];
            
        }else {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            label.text = title;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:_sheetRightTitleFont];
            label.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:label];
        }
        
    }
    
    if (_showAllSheetBorder) {

        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, width, 1)];
        bottomLine.backgroundColor = _sheetLineColor;
        [bgView addSubview:bottomLine];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - 1, 0, 1, height)];
        rightLine.backgroundColor = _sheetLineColor;
        [bgView addSubview:rightLine];
    }
    
    return bgView;
}



@end
