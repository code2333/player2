//
//  ViewController.m
//  hardPlayer
//
//  Created by 罗邦杰 on 16/5/15.
//  Copyright © 2016年 罗邦杰. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "hotTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "secondViewController.h"

#define IMAGEURL_API @"http://route.showapi.com/213-4?showapi_appid=6091&topid=5&showapi_sign=a3b9cb3921c74e0ba31d2d7b2fbbed77"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionDelegate>{
    NSMutableArray *_listarr;
}

@property (nonatomic, strong,readwrite) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong)  UIButton * loadButton;
@property (strong, nonatomic)AVAudioPlayer *voicePlayer;
@property (nonatomic,strong)  UIButton *playButton;
@property (strong,nonatomic) UIButton *stopButton;
@property (strong,nonatomic) UIButton *lastButton;
@property (strong,nonatomic) UIButton *nextButton;
@property (strong,nonatomic) UILabel *songName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _songName = [[UILabel alloc]initWithFrame:CGRectMake(30, [UIScreen mainScreen].bounds.size.height-190, 400, 200)];
    _songName.textColor = [UIColor blackColor];
     _songName.font = [UIFont boldSystemFontOfSize:15.0f];
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -200) style:UITableViewStylePlain];
    _loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loadButton.layer.masksToBounds = YES;
    _loadButton.layer.cornerRadius = 1.0;
    _loadButton.frame = CGRectMake(0, 20 , [UIScreen mainScreen].bounds.size.width,50);
    _loadButton.backgroundColor = [UIColor colorWithRed:144.0f/225.0f green:238.0f/225.0f blue:144.0f/225.0f alpha:0.8];
    [_loadButton setTitle:@"热门榜单" forState:UIControlStateNormal];
    [_loadButton addTarget:self action:@selector(downLoadImage) forControlEvents:UIControlEventTouchUpInside];
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.frame = CGRectMake(130, [UIScreen mainScreen].bounds.size.height-70 , 50, 50);
    _playButton.backgroundColor = [UIColor colorWithRed:144.0f/225.0f green:238.0f/225.0f blue:144.0f/225.0f alpha:0.8];
    _playButton.layer.masksToBounds = YES;
    _playButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _playButton.layer.borderWidth = 1;
    _playButton.layer.cornerRadius = 25.0;
    [ _playButton setTitle:@"play" forState:UIControlStateNormal];
    [ _playButton addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];

    _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _stopButton.frame = CGRectMake(230, [UIScreen mainScreen].bounds.size.height-70 , 50, 50);
    _stopButton.backgroundColor = [UIColor colorWithRed:144.0f/225.0f green:238.0f/225.0f blue:144.0f/225.0f alpha:0.8];
    _stopButton.layer.masksToBounds = YES;
    _stopButton.layer.borderColor = [[UIColor blackColor]CGColor];
    _stopButton.layer.borderWidth = 1;
    _stopButton.layer.cornerRadius = 25.0;
    [ _stopButton setTitle:@"stop" forState:UIControlStateNormal];
    [ _stopButton addTarget:self action:@selector(stopMusic) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:self.songName];
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.playButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)lastMusci{
    
}

- (void)playMusic{
    static int num=1;
    if(_voicePlayer != Nil){
    if (num) {
        [_voicePlayer pause];
        [ _playButton setTitle:@"play" forState:UIControlStateNormal];
        num--;
    }
    else{
    [_voicePlayer play];
    [ _playButton setTitle:@"pause" forState:UIControlStateNormal];
        num++;
    }
    }
}

- (void)stopMusic{
    [_voicePlayer stop];
    [ _playButton setTitle:@"play" forState:UIControlStateNormal];
    _voicePlayer = Nil;
}

- (void)downLoadImage {
    NSURL *URL = [NSURL URLWithString:IMAGEURL_API];
    NSURLRequest *requset = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            __weak typeof(self) weakSelf = self;
            _dataArray = [NSMutableArray arrayWithArray:dic[@"showapi_res_body"][@"pagebean"][@"songlist"]];
            [weakSelf.view addSubview:weakSelf.tableView];
    
        }
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    

    secondViewController *sec = [[secondViewController alloc]init];
    NSLog(@"%@",self.navigationController);
    sec.songName = self.dataArray[indexPath.row][@"songname"] ;
    _songName.text =self.dataArray[indexPath.row][@"songname"] ;
    NSLog(@"%@",sec.songName);
    [self.navigationController pushViewController:sec animated:YES];
    NSURL *url = [NSURL URLWithString:self.dataArray[indexPath.row][@"url"]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:100];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    [task resume];

}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    _voicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:location error:nil];
    
    [_voicePlayer  setVolume:1];
    
    _voicePlayer.numberOfLoops = -1;
    
    [_voicePlayer play];
    
    [ _playButton setTitle:@"pause" forState:UIControlStateNormal];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    hotTableViewCell *cell = [hotTableViewCell cellWithTableView:tableView];
    cell.songName.text = self.dataArray[indexPath.row][@"songname"];
    cell.singerName.text = self.dataArray[indexPath.row][@"singername"];
    [cell.songImage sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row][@"albumpic_small"]]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
