//
//  BaseTableViewCell.m
//  SportsSpeedTest
//
//  Created by Felix on 2018/7/4.
//  Copyright © 2018年 DW. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (instancetype _Nullable )createCellWithTableView:(UITableView *_Nullable)tableView {
    
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault
                          reuseIdentifier:reuseIdentifier];
        cell.tableView = tableView;
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellStyle];
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置控件约束
- (void)setupUI {
    
}

#pragma mark - 修改cell属性
- (void)setupCellStyle {
    
}

@end
