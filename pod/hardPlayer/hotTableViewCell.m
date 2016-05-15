//
//  hotTableViewCell.m
//  hardPlayer
//
//  Created by 罗邦杰 on 16/5/15.
//  Copyright © 2016年 罗邦杰. All rights reserved.
//

#import "hotTableViewCell.h"

@implementation hotTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUi];
    }
    return self;
}

- (void)setupUi {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _songName = [[UILabel alloc]initWithFrame:CGRectMake(110,25,375,20)];
    _songName.numberOfLines = 0;
    _songName.font = [UIFont boldSystemFontOfSize:10.0f];
    _singerName = [[UILabel alloc]initWithFrame:CGRectMake(110,65,200,20)];
    _singerName.font = [UIFont boldSystemFontOfSize:10.0f];
    _songImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,90,90)];

    [self.contentView addSubview:_songName];
    [self.contentView addSubview:_singerName];
    [self.contentView addSubview:_songImage];
}


+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identify = @"cell";
    hotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[hotTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];
    }
    return cell;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
