//
//  ParameterSectionHeaderView.m
//  UITableViewLInkageDemo
//
//  Created by Eleven on 2017/7/3.
//  Copyright © 2016年 Hawk. All rights reserved.
//

#import "ConfigSectionHeaderView.h"

@implementation ConfigSectionHeaderView
{
    /// 标题
    __weak IBOutlet UILabel *_title;
    /// 向下箭头
    __weak IBOutlet UIImageView *_arrow;
}

-(void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ConfigSectionHeaderView" owner:self options:nil] objectAtIndex:0];
}


@end
