//
//  hotTableViewCell.h
//  hardPlayer
//
//  Created by 罗邦杰 on 16/5/15.
//  Copyright © 2016年 罗邦杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *songName;

@property (strong,nonatomic) UILabel *singerName;

@property (strong,nonatomic) UIImageView *songImage;



+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
