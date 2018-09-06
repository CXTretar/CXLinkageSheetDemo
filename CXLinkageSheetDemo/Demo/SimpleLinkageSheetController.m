//
//  SimpleLinkageSheetController.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "SimpleLinkageSheetController.h"
#import "CXLinkageSheetView.h"

@interface SimpleLinkageSheetController ()

@property (nonatomic, strong) CXLinkageSheetView *linkageSheetView;

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
    
    NSMutableArray *leftDataArray = @[].mutableCopy;
  
    for (NSInteger i = 0; i < 12; i ++ ) {
        NSString *leftString = [NSString stringWithFormat:@"竖 %ld", i];
        [leftDataArray addObject:leftString];
    }
    
    NSMutableArray *rightDataArray = @[].mutableCopy;
    
    for (NSInteger i = 0; i < 10; i ++ ) {
        NSString *rightString = [NSString stringWithFormat:@"横 %ld", i];
        [rightDataArray addObject:rightString];
        
    }
    
    NSMutableArray *rightDetailArray = @[].mutableCopy;
    for (NSInteger x = 0; x < leftDataArray.count; x ++) {
        NSMutableArray *tempArray = @[].mutableCopy;
        for (NSInteger y = 0; y < rightDataArray.count; y ++) {
            [tempArray addObject:[NSString stringWithFormat:@"X%ld - Y%ld", x, y]];
        }
        [rightDetailArray addObject:tempArray];
    }
   
    _linkageSheetView.leftTitleArray = leftDataArray.copy;
    _linkageSheetView.rightTitleArray = rightDataArray.copy;
    _linkageSheetView.rightDetailArray = rightDetailArray.copy;
    _linkageSheetView.showAllSheetBorder = YES;
    _linkageSheetView.sheetHeaderHeight = 60;
    _linkageSheetView.sheetRowHeight = 50;
    _linkageSheetView.sheetLeftTableWidth = 80.0;
    _linkageSheetView.sheetRightTableWidth = 100;
//    _linkageSheetView.autoMinRightTableCount = 5;
    [_linkageSheetView reloadData];
}


@end
