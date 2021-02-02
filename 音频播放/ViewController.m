//
//  ViewController.m
//  音频播放01
//
//  Created by karajan on 2021/2/1.
//  Copyright © 2021 karajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //播放按钮
    _btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPlay.frame = CGRectMake(100, 100, 100, 40);
    [_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    _btnPlay.titleLabel.textColor = [UIColor blackColor];
    [_btnPlay addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPlay];
    
    //暂停按钮
    _btnPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPause.frame = CGRectMake(100, 160, 100, 40);
    [_btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [_btnPause addTarget:self action:@selector(pressPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPause];
    
    //停止按钮
    _btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnStop.frame = CGRectMake(100, 220, 100, 40);
    [_btnStop setTitle:@"停止" forState:UIControlStateNormal];
    [_btnStop addTarget:self action:@selector(pressStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnStop];
    
    //进度条
    _musicProgress = [[UIProgressView alloc] init];
    _musicProgress.frame = CGRectMake(10, 300, 350, 20);
    _musicProgress.progress = 0;
    [self.view addSubview:_musicProgress];
    
    //声音控制滑轨
    _volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 350, 350, 10)];
    _volumeSlider.maximumValue = 100;
    _volumeSlider.minimumValue = 0;
    [_volumeSlider addTarget:self action:@selector(volumChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_volumeSlider];
    
    [self createAVPlayer];
}

-(void)createAVPlayer{
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"夜空中最亮的星" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:pathStr];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];
    _player.volume = 0.5;
    _player.numberOfLoops = 1;
    
    _player.delegate = self;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self pressStop];
}

-(void)pressPlay{
    NSLog(@"播放按钮");
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    //开始播放
    [_player play];
    _musicProgress.progress = _player.currentTime / _player.duration;
    
    _volumeSlider.value = _player.volume * 100;
    
}

-(void)pressPause{
    NSLog(@"暂停按钮");
    [_player pause];
}

-(void)pressStop{
    NSLog(@"停止按钮");
    [_player stop];
    _player.currentTime = 0;
    [_timer invalidate];
}

-(void)volumChange:(UISlider *)slider{
    NSLog(@"声音改变 == %f",slider.value);
    _player.volume = slider.value / 100;
}

-(void)updateProgress{
    NSLog(@"进度条更新");
    _musicProgress.progress = _player.currentTime / _player.duration;
}
@end
