//
//  DetailViewController.m
//  NewsList
//
//  Created by Johnson on 2022/6/17.
//

#import "DetailViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *createLabel;
@property (nonatomic, strong) UILabel *createrLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"新闻详情"];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.createLabel];
    [self.contentView addSubview:self.createrLabel];
    [self.contentView addSubview:self.lineImageView];
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@(0));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.9);
        make.top.equalTo(@(20));
    }];
    
    [self.createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
    }];
//
    [self.createrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.createLabel.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
    }];
//
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.createrLabel.mas_bottom).offset(20);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(1));
    }];
//
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(self.lineImageView.mas_bottom).offset(20);
        make.width.equalTo(self.view.mas_width).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getData];
}

- (void)getData {
    NSMutableString *url = [NSMutableString stringWithFormat:@"https://wsy.cosmoplat.com/dev-api/cms/articles/"];
    [url appendString:self.noteId];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject[@"data"];
        self.titleLabel.text = data[@"title"];
        self.createLabel.text = data[@"createdBy"];
        self.createrLabel.text = data[@"createdAt"];
//        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[data[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        NSString*detailTextString = [NSString stringWithFormat:@"%@",data[@"content"]];

//        NSString*str = [NSString stringWithFormat:@"%@",SCREEN_WIDTH,detailTextString];
        NSMutableAttributedString*attributeString = [[NSMutableAttributedString alloc]initWithData:[detailTextString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        self.contentLabel.attributedText = attributeString;
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)createLabel {
    if (!_createLabel) {
        _createLabel = [[UILabel alloc] init];
        _createLabel.font = [UIFont systemFontOfSize:13];
        _createLabel.textColor = [UIColor grayColor];
        _createLabel.numberOfLines = 0;
    }
    return _createLabel;
}

- (UILabel *)createrLabel {
    if (!_createrLabel) {
        _createrLabel = [[UILabel alloc] init];
        _createrLabel.font = [UIFont systemFontOfSize:13];
        _createrLabel.textColor = [UIColor grayColor];
        _createrLabel.numberOfLines = 0;
    }
    return _createrLabel;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
