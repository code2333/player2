//
//  secondViewController.m
//  hardPlayer
//
//  Created by 罗邦杰 on 16/5/15.
//  Copyright © 2016年 罗邦杰. All rights reserved.
//

#import "secondViewController.h"

@interface secondViewController ()

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _songName.frame = CGRectMake(130, [UIScreen mainScreen].bounds.size.height-70 , 50, 50);
    [self.view addSubview:_songName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
