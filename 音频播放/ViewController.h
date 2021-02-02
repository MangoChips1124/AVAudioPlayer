//
//  ViewController.h
//  音频播放01
//
//  Created by karajan on 2021/2/1.
//  Copyright © 2021 karajan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
//导入视频音频播放系统库文件

@interface ViewController : UIViewController
//音频播放协议
<AVAudioPlayerDelegate>
{
    //播放按钮
    UIButton *_btnPlay;
    
    //暂停播放
    UIButton *_btnPause;
    
    //停止播放
    UIButton *_btnStop;
    
    //进度条
    UIProgressView *_musicProgress;
    
    //声音大小调整滑动条
    UISlider *_volumeSlider;
    
    //静音开关
    UISwitch *_volumOn;
    
    //音频播放器对象
    AVAudioPlayer *_player;
    
    //定义声明一个定时器对象
    NSTimer *_timer;
}

@end

