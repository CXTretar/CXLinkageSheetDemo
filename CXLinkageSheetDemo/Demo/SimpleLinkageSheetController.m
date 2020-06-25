//
//  SimpleLinkageSheetController.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "SimpleLinkageSheetController.h"
#import "CXLinkageSheetView.h"

@interface SimpleLinkageSheetController ()<CXLinkageSheetViewDataSource>

@property (nonatomic, strong) CXLinkageSheetView *linkageSheetView;

@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) NSMutableArray *rightDataArray;
@property (nonatomic, strong) NSMutableArray *rightDetailArray;

@end

@implementation SimpleLinkageSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    self.linkageSheetView = [[CXLinkageSheetView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    _linkageSheetView.center = self.view.center;
    [self.view addSubview:_linkageSheetView];
    
    self.leftDataArray = @[].mutableCopy;
    
    for (NSInteger i = 0; i < 20; i ++ ) {
        NSString *leftString = [NSString stringWithFormat:@"竖 %ld", i];
        [_leftDataArray addObject:leftString];
    }
    
    self.rightDataArray = @[].mutableCopy;
    
    for (NSInteger i = 0; i < 15; i ++ ) {
        NSString *rightString = [NSString stringWithFormat:@"横 %ld", (long)i];
        [_rightDataArray addObject:rightString];
        
    }
    
    self.rightDetailArray = @[].mutableCopy;
    for (NSInteger x = 0; x < _leftDataArray.count; x ++) {
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSInteger y = 0; y < _rightDataArray.count; y ++) {
            [tempArray addObject:[NSString stringWithFormat:@"X%ld - Y%ld", (long)x, (long)y]];
        }
        [_rightDetailArray addObject:tempArray];
    }
    
    _linkageSheetView.sheetHeaderHeight = 60;
    _linkageSheetView.sheetRowHeight = 50;
    _linkageSheetView.sheetLeftTableWidth = 80.0;
    _linkageSheetView.sheetRightTableWidth = 100;
    _linkageSheetView.showAllSheetBorder = YES;
    _linkageSheetView.pagingEnabled = YES;
    _linkageSheetView.leftTableCount = _leftDataArray.count;
    _linkageSheetView.rightTableCount = _rightDataArray.count;
    _linkageSheetView.dataSource = self;
    _linkageSheetView.showScrollShadow = YES;
    [_linkageSheetView reloadData];
}

- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, contentView.bounds.size.height)];
    label.text = self.leftDataArray[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    return label;
}

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex {
    UILabel *label = [[UILabel alloc]initWithFrame:contentView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _rightDetailArray[indexPath.row][itemIndex];
    label.font = [UIFont systemFontOfSize:11];
    return label;
}

- (UIView *)leftTitleView:(UIView *)titleContentView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleContentView.bounds.size.width, titleContentView.bounds.size.height)];
    label.text = @"标题栏";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    return label;
}

- (UIView *)rightTitleView:(UIView *)titleContentView index:(NSInteger)index {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleContentView.bounds.size.width, titleContentView.bounds.size.height)];
    label.text = self.rightDataArray[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];

    return label;

}

@end
