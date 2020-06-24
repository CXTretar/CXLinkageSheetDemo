//
//  ViewController.m
//  CXLinkageSheetDemo
//
//  Created by Felix on 2018/9/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *classArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classArray = @[@"SimpleLinkageSheetController",@"CustomLinkageSheetController"].copy;
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)setupUI {

    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.classArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *class = self.classArray[indexPath.row];
    id vc = [[NSClassFromString(class) alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        UIViewController *VC = (UIViewController *)vc;
        VC.title = class;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
 
}



@end
