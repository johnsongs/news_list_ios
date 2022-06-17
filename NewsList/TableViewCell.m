//
//  TableViewCell.m
//  NewsList
//
//  Created by Johnson on 2022/6/17.
//

#import "TableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface TableViewCell ()

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.newsImageView];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.content];
        
        [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(10));
            make.width.and.height.equalTo(@(90));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(10));
            make.left.equalTo(self.newsImageView.mas_right).offset(10);
            make.width.equalTo(self.mas_width).offset(-90-10-10-10);
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).offset(10);
            make.left.equalTo(self.newsImageView.mas_right).offset(10);
            make.width.equalTo(self.mas_width).offset(-90-10-10-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(@(110));
            
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillData:(NSDictionary *)data {
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:data[@"imageUrl"]]];
    self.title.text = data[@"title"];
    self.content.text = data[@"summary"];
}

- (UIImageView *)newsImageView {
    if (!_newsImageView) {
        _newsImageView = [[UIImageView alloc] init];
    }
    return _newsImageView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont boldSystemFontOfSize:14];
        _title.numberOfLines = 0;
    }
    return _title;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.textColor = [UIColor blackColor];
        _content.font = [UIFont systemFontOfSize:12];
        _content.numberOfLines = 0;
    }
    return _content;
}


@end
