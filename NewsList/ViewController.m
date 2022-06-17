//
//  ViewController.m
//  NewsList
//
//  Created by Johnson on 2022/6/17.
//

#import "ViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "TableViewCell.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *nationalBtn;
@property (nonatomic, strong) UIButton *worldBtn;
@property (nonatomic, strong) NSString *cateCode;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻列表";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    self.cateCode = @"news.center.domestic";
    
    self.nationalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nationalBtn setTitle:@"国内新闻" forState:UIControlStateNormal];
    self.nationalBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.nationalBtn.layer.borderWidth = 1;
    [self.nationalBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.nationalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nationalBtn addTarget:self action:@selector(changeChannelEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.nationalBtn setSelected:YES];
    [self.view addSubview:self.nationalBtn];
    [self.nationalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(@(44));
    }];
    
    self.worldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.worldBtn setTitle:@"国外新闻" forState:UIControlStateNormal];
    self.worldBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.worldBtn.layer.borderWidth = 1;
    [self.worldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.worldBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.view addSubview:self.worldBtn];
    [self.worldBtn addTarget:self action:@selector(changeChannelEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.worldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nationalBtn.mas_right);
        make.top.equalTo(@(0));
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(@(44));
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.worldBtn.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)changeChannelEvent:(UIButton *)button {
    [button setSelected:YES];
    if (button == self.nationalBtn) {
        [self.worldBtn setSelected:NO];
        self.page = 1;
        self.cateCode = @"news.center.domestic";
        [self getData];
    }else {
        [self.nationalBtn setSelected:NO];
        self.cateCode = @"news.center.world";
        self.page = 1;
        [self getData];
    }
}

- (void)getData {
    [[AFHTTPSessionManager manager] GET:@"https://wsy.cosmoplat.com/dev-api/cms/articles/page" parameters:@{@"cateCode":self.cateCode,@"pageNo":@(self.page),@"pageSize":@(10)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tableData = responseObject[@"data"][@"records"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell fillData:self.tableData[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.noteId = self.tableData[indexPath.section][@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
