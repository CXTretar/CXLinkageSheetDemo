//
//  CustomLinkageSheetController.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "CustomLinkageSheetController.h"
#import "CXLinkageSheetView.h"
#import "CarModel.h"
#import <YYModel.h>

@interface CustomLinkageSheetController ()<CXLinkageSheetViewDataSource>


@property (nonatomic, strong) CXLinkageSheetView *linkageSheetView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CustomLinkageSheetController

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].copy;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    self.linkageSheetView = [[CXLinkageSheetView alloc]initWithFrame:self.view.bounds];
    self.linkageSheetView.dataSource = self;
    [self.view addSubview:_linkageSheetView];
    
}

- (void)loadData {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"custom_data" ofType:@"json"]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    self.dataArray = [NSArray yy_modelArrayWithClass:[CarModel class] json:dict[@"data"]].mutableCopy;
    [self.linkageSheetView reloadData];
    NSLog(@"%@", self.dataArray.yy_modelDescription);
    
    
}

//- (UITableViewCell *)leftTableView:(UITableView *)leftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    
//    return [UITableViewCell new];
//}

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex {
    return nil;
}

- (UIView *)rightTitleView:(UIView *)titleContentView index:(NSInteger)index {
    return nil;
}

@end
