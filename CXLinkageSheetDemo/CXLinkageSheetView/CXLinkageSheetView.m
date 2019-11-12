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

@implementation PathResponseView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGPathIsEmpty(self.path.CGPath)) {
        return YES;
    } else if (CGPathContainsPoint(self.path.CGPath, nil, point, nil)) {
        return YES;
    } else {
        return NO;
    }
}

@end


@interface CXLinkageSheetView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CXLinkageSheetLeftCellDataSourse, CXLinkageSheetRightCellDataSourse, CXLinkageSheetRightCellDelegate>

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
        self.outLineColor = [UIColor lightGrayColor];
        self.outLineWidth = 1.0;
        self.innerLineColor = [UIColor lightGrayColor];
        self.innerLineWidth = 1.0;

        self.sheetHeaderHeight = 44.f;
        self.sheetRowHeight = 44.f;
        self.sheetLeftTableWidth = self.width / 3.0;
        self.sheetRightTableWidth = self.width / 3.0;
        [self setupUI];
        
        
    }
    return self;
}

#pragma mark - 刷新视图UI以及数据源

- (void)reloadData {
    
    if (self.autoMinRightTableCount != 0) {
        
        self.sheetRightTableWidth = (self.width - _sheetLeftTableWidth) / _autoMinRightTableCount;
        if ((self.width - _sheetLeftTableWidth) > self.rightTableCount * self.sheetRightTableWidth) {
            self.sheetRightTableWidth = (self.width - _sheetLeftTableWidth) / self.rightTableCount;
        }
        
    }
    
    self.contentSizeWidth = _sheetRightTableWidth * _rightTableCount;
    
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    if (self.rightTableCount) {
        [self setupUI];
    }
}

#pragma mark - 创建视图控件

- (void)setupUI {
    
    self.rightContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(_sheetLeftTableWidth, 0, self.width - _sheetLeftTableWidth, self.height)];
    _rightContentView.delegate = self;
    _rightContentView.showsVerticalScrollIndicator = NO;
    _rightContentView.showsHorizontalScrollIndicator = NO;
    _rightContentView.contentSize = CGSizeMake(_contentSizeWidth, self.height);
    _rightContentView.bounces = NO;
    if (@available(iOS 11.0, *)){
        _rightContentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self addSubview:_rightContentView];
    
    UIView *titleLabel = [self createTitleViewWithLeft:0 width:_sheetLeftTableWidth height:_sheetHeaderHeight index:-1];
    [self addSubview:titleLabel];
    
    for (int i = 0; i < self.rightTableCount; i++) {
        CGFloat x = i * _sheetRightTableWidth;
        UIView *titleView = [self createTitleViewWithLeft:x width:_sheetRightTableWidth height:_sheetHeaderHeight index:i];
        [_rightContentView addSubview:titleView];
    }
    [self configTableView];
    
    if (_showAllSheetBorder) {
        CGFloat height = self.height < (_sheetRowHeight * self.leftTableCount + _sheetHeaderHeight) ? self.height : (_sheetRowHeight * self.leftTableCount + _sheetHeaderHeight);
        CGFloat width = self.width < (_sheetRightTableWidth * self.rightTableCount + _sheetLeftTableWidth) ? self.width : (_sheetRightTableWidth * self.rightTableCount + _sheetLeftTableWidth);
        
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _outLineWidth, height)];
        leftLine.backgroundColor = _outLineColor;
        [self addSubview:leftLine];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - _outLineWidth, 0, _outLineWidth, height)];
        rightLine.backgroundColor = _outLineColor;
        [self addSubview:rightLine];
        
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, _outLineWidth)];
        upLine.backgroundColor = _outLineColor;
        [self addSubview:upLine];
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, height - _outLineWidth, width, _outLineWidth)];
        bottomLine.backgroundColor = _outLineColor;
        [self addSubview:bottomLine];
    }
}

- (void)configTableView {
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sheetHeaderHeight, _contentSizeWidth, self.height - _sheetHeaderHeight) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.bounces = NO;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.showsHorizontalScrollIndicator = NO;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.backgroundColor = [UIColor clearColor];
    [_rightContentView addSubview:_rightTableView];
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sheetHeaderHeight, self.width, self.height - _sheetHeaderHeight) style:UITableViewStylePlain];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.bounces = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.showsHorizontalScrollIndicator = NO;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = [UIColor clearColor];
    [_leftTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
    
    PathResponseView *leftBgView = [[PathResponseView alloc]initWithFrame:self.leftTableView.bounds];
    
    leftBgView.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, _sheetHeaderHeight, _sheetLeftTableWidth, self.height - _sheetHeaderHeight)];
    
    [leftBgView addSubview:self.leftTableView];
    [self addSubview:leftBgView];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_dataSource respondsToSelector:@selector(numberOfRowsInSheetViewSection:)]) {
        return [_dataSource numberOfRowsInSheetViewSection:section];
        
    }
    return _leftTableCount;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInSheetView)]) {
        return  [_dataSource numberOfSectionsInSheetView];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTableView) {
        CXLinkageSheetLeftCell *cell = [CXLinkageSheetLeftCell createCellWithTableView:tableView ];
        cell.showBorder = _showAllSheetBorder;
        cell.indexPath = indexPath;
        cell.cellWidth = _sheetLeftTableWidth;
        cell.lineColor = _innerLineColor;
        cell.lineWidth = _innerLineWidth;
        cell.showBorder = _showAllSheetBorder;
        cell.dataSourse = self;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    } else {
        
        CXLinkageSheetRightCell *cell = [CXLinkageSheetRightCell createCellWithTableView:tableView];
        cell.itemWidth = _sheetRightTableWidth;
        cell.itemHeight = _sheetRowHeight;
        cell.lineColor = _innerLineColor;
        cell.lineWidth = _innerLineWidth;
        cell.showBorder = _showAllSheetBorder;
        cell.itemCount = _rightTableCount;
        cell.dataSourse = self;
        cell.indexPath = indexPath;
        cell.delegate = self;
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        if ([_dataSource respondsToSelector:@selector(viewForSheetViewHeaderInSection:)]) {
            [headerView addSubview: [_dataSource viewForSheetViewHeaderInSection:section]];
        }
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([_dataSource respondsToSelector:@selector(heightForSheetViewHeaderInSection:)]) {
        return [_dataSource heightForSheetViewHeaderInSection:section];
    }
    
    return CGFLOAT_MIN;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _sheetRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_leftTableView] && [_delegate respondsToSelector:@selector(leftTableView:didSelectRowAtIndexPath:)]) {
        [_delegate leftTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - CXLinkageSheetLeftCellDataSourse

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex {
    
    if ([_dataSource respondsToSelector:@selector(createRightItemWithContentView:indexPath:itemIndex:)]) {
        return [_dataSource createRightItemWithContentView:contentView indexPath:indexPath itemIndex:itemIndex];
    }
    return nil;
}

#pragma mark - CXLinkageSheetRightCellDataSourse

- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath {
    
    if ([_dataSource respondsToSelector:@selector(createLeftItemWithContentView:indexPath:)]) {
        return [_dataSource createLeftItemWithContentView:contentView indexPath:indexPath];
    }
    return nil;
}

#pragma mark - CXLinkageSheetRightCellDelegate

- (void)didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath andItemIndex:(NSInteger )itemIndex {
    if ([_delegate respondsToSelector:@selector(rightTableView:didSelectRowAtIndexPath:andItemIndex:)]) {
        [_delegate rightTableView:_rightTableView didSelectRowAtIndexPath:indexPath andItemIndex:itemIndex];
    }
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

#pragma mark - UIScrollViewDelegate 分页滚动

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == _rightContentView && _pagingEnabled) {
        CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
        targetContentOffset->x = targetOffset.x;
        targetContentOffset->y = targetOffset.y;
    }
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset {
    CGFloat pageSize =_sheetRightTableWidth;
    NSInteger page = roundf(offset.x / pageSize);
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

#pragma mark - 快速创建顶部标题栏视图

- (UIView *)createTitleViewWithLeft:(CGFloat)left width:(CGFloat)width height:(CGFloat)height index:(NSInteger)index {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(left, 0, width, height)];
    
    if (index >= 0) {
        
        if ([_dataSource respondsToSelector:@selector(rightTitleView:index:)]) {
            [bgView addSubview:[_dataSource rightTitleView:bgView index:index]];
        }
    }else {
        if ([_dataSource respondsToSelector:@selector(leftTitleView:)]) {
            [bgView addSubview:[_dataSource leftTitleView:bgView]];
        }
        
    }
    
    if (_showAllSheetBorder) {
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - _innerLineWidth, width, _innerLineWidth)];
        bottomLine.backgroundColor = _innerLineColor;
        [bgView addSubview:bottomLine];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - _innerLineWidth, 0, _innerLineWidth, height)];
        rightLine.backgroundColor = _innerLineColor;
        [bgView addSubview:rightLine];
    }
    
    return bgView;
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end
