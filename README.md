# CXLinkageSheetDemo
### 效果
![normal](https://github.com/CXTretar/CXLinkageSheetDemo/blob/master/gif/normal.gif)
![custom](https://github.com/CXTretar/CXLinkageSheetDemo/blob/master/gif/custom.gif)

# Update【更新】
- 11.12 新增了左侧表格和右侧表格的点击事件。

# Install【安装】

在Podfile文件中添加`pod 'CXLinkageSheetView'`，并运行 `pod install`

# Usage【使用】

* import【导入框架】
`#import "CXLinkageSheetView.h"`

* protocol【协议】
```
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

```

* custom【自定义属性和方法】

```
@property (nonatomic, weak, nullable) id <CXLinkageSheetViewDataSource> dataSource;

@property (nonatomic, assign) NSInteger leftTableCount;         // 左边表格行数,即纵向行数
@property (nonatomic, assign) NSInteger rightTableCount;        // 右边表格行数,即横向行数,必须要赋值

@property (nonatomic, strong) UIColor * _Nullable outLineColor;            // 表格外部分割线颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, assign) CGFloat outLineWidth;             // 表格分割线宽度, 默认为 1.0
@property (nonatomic, strong) UIColor * _Nullable innerLineColor;          // 表格内部格子分割线颜色, 默认为 [UIColor lightGrayColor]
@property (nonatomic, assign) CGFloat innerLineWidth;           // 表格内部格子分割线宽度, 默认为 1.0
@property (nonatomic, assign) CGFloat sheetHeaderHeight;        // 表格头部高度, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetRowHeight;           // 表格行高, 默认 44.0f
@property (nonatomic, assign) CGFloat sheetLeftTableWidth;      // 表格左侧宽度, 默认为整个表格的 1/3
@property (nonatomic, assign) CGFloat sheetRightTableWidth;     // 表格右侧宽度, 默认为整个表格的 1/3

@property (nonatomic, assign) NSInteger autoMinRightTableCount; // 自动分配表格右侧宽度, 右侧表格会显示该值对应的个数,设置了这个值有会导致 sheetRightTableWidth 失效

@property (nonatomic, assign) BOOL showAllSheetBorder;          // 展示所有格子的分割线
@property (nonatomic, assign) BOOL pagingEnabled;               // 开启右侧表格横向滚动分页效果, 分页距离为 单个格子宽度

- (void)reloadData;

```
* example【示例】 
#### 创建视图
```
    self.linkageSheetView = [[CXLinkageSheetView alloc]initWithFrame:CGRectMake(0, kTopHeight, CXScreenW, CXScreenH - kTopHeight)];
    _linkageSheetView.sheetHeaderHeight = 60;
    _linkageSheetView.sheetRowHeight = 50;
    _linkageSheetView.sheetLeftTableWidth = CXScreenW / 4;
    _linkageSheetView.sheetRightTableWidth = CXScreenW / 4;
    _linkageSheetView.showAllSheetBorder = YES;
    _linkageSheetView.pagingEnabled = YES;
    _linkageSheetView.dataSource = self;
    _linkageSheetView.outLineColor = LightGrayColor;
    _linkageSheetView.outLineWidth = 0.5f;
    _linkageSheetView.innerLineColor = LightGrayColor;
    _linkageSheetView.innerLineWidth = 1.0f;
    [self.view addSubview:_linkageSheetView];
```
#### 通过 CXLinkageSheetViewDataSource 自定义样式
```
#pragma mark - 表格section数目

- (NSInteger)numberOfSectionsInSheetView {
    return self.firstCarModel.groupParamsViewModelList.count;
}

#pragma mark - 自定义表格section头部视图

- (UIView *)viewForSheetViewHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CXScreenW, 30)];
    sectionHeader.backgroundColor = LightGrayColor;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, CXScreenW / 4 - 16, 30)];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[section];
    titleLabel.text = groupParamsModel.groupName;
    [sectionHeader addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CXScreenW - 80, 0, 80, 30)];
    detailLabel.font = [UIFont systemFontOfSize:10];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = DarkGrayColor;
    detailLabel.text = @"标配   选配 - 无";
    [sectionHeader addSubview:detailLabel];
    
    return sectionHeader;
}

#pragma mark - 表格section头部视图高度

- (CGFloat)heightForSheetViewHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - 表格每一个section的行数

- (NSInteger)numberOfRowsInSheetViewSection:(NSInteger)section {
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[section];
    
    return groupParamsModel.paramList.count;
}

#pragma mark - 自定义表格左侧标题视图

- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, contentView.bounds.size.width - 20, contentView.bounds.size.height)];
  
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.textColor = DarkGrayColor;
    
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[indexPath.section];
    ParamlistModel *paramlistModel = groupParamsModel.paramList[indexPath.row];
    label.text = paramlistModel.paramName;
    
    return label;
}

#pragma mark - 自定义表格右侧每一个格子的视图

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, contentView.bounds.size.width - 20, contentView.bounds.size.height)];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = DarkGrayColor;
    
    CarModel *carModel = self.dataArray[itemIndex];
    GroupParamsModel *groupParamsModel = carModel.groupParamsViewModelList[indexPath.section];
    ParamlistModel *paramlistModel = groupParamsModel.paramList[indexPath.row];
    
    label.text = paramlistModel.paramValue;
    
    return label;
}

#pragma mark - 自定义表格左上角视图

- (UIView *)leftTitleView:(UIView *)titleContentView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleContentView.bounds.size.width, titleContentView.bounds.size.height)];
    label.text = @"配置项";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = DarkGrayColor;
    return label;
}

#pragma mark - 自定义表格右侧标题视图

- (UIView *)rightTitleView:(UIView *)titleContentView index:(NSInteger)index {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleContentView.bounds.size.width - 20, titleContentView.bounds.size.height)];
    CarModel *carModel = self.dataArray[index];
    label.text = carModel.specName;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    return label;
}

```
#### 通过 CXLinkageSheetViewDelegate 点击事件
```
#pragma mark - 左侧表格视图点击事件

- (void)leftTableView:(UITableView * _Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nullable)indexPath {
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[indexPath.section];
    ParamlistModel *paramlistModel = groupParamsModel.paramList[indexPath.row];

    NSLog(@"%@ -- %@", indexPath, paramlistModel.yy_modelDescription);
}

#pragma mark - 右侧表格视图点击事件

- (void)rightTableView:(UITableView *_Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath andItemIndex:(NSInteger )itemIndex {
    CarModel *carModel = self.dataArray[itemIndex];
    GroupParamsModel *groupParamsModel = carModel.groupParamsViewModelList[indexPath.section];
    ParamlistModel *paramlistModel = groupParamsModel.paramList[indexPath.row];
    
    NSLog(@"%@ -- %ld -- %@", indexPath, (long)itemIndex, paramlistModel.yy_modelDescription);
}

```
