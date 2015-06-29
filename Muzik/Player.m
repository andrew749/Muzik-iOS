//
//  Player.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-06.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "Player.h"
#import "Muzik-Swift.h"
#import <UIKit/UIKit.h>
@import AVFoundation;
@interface Player ()
@property (strong,readwrite)UIImage* playImage;
@property (strong,readwrite)UIImage* pauseImage;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (strong,readwrite)NSTimer* timer;
@property BOOL timestate;
@end
@implementation Player
@synthesize song;
@synthesize songLabel;
@synthesize playButton;
@synthesize playImage;
@synthesize pauseImage;
MusicManager* manager;
- (IBAction)stopClick:(id)sender {
    [self stopSong];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [songLabel setText:[song getSongTitle]];
    playImage=[UIImage imageNamed:@"playbuttonblack.png"];
    pauseImage=[UIImage imageNamed:@"pausebuttonblack.png"];
    if(self.image){
        self.albumImage.image=self.image;
    }
    manager=[MusicManager getObjInstance];
    if(manager.state == STATENOT_PLAYING){
        [self startSong];
        [playButton setImage:pauseImage forState:UIControlStateNormal];
    }else{
        if([manager isLoaded]){
            if (![manager.url.absoluteString isEqualToString:[self.song getSongURL].absoluteString]){
                [self startSong];
            }
            if(manager.state == STATEPLAYING){
                [playButton setImage:pauseImage forState:UIControlStateNormal];
            }else{
                [playButton setImage:playImage forState:UIControlStateNormal];
            }
        }
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer=nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateBar) userInfo:nil repeats:YES];
}
-(void)updateBar{
    int seconds=CMTimeGetSeconds([manager getTime]);
    if (seconds > 0){
        _currentTime.text=[NSString stringWithFormat:@"%d:%02d",seconds/60,seconds%60];
        int totalSeconds=CMTimeGetSeconds([manager songLength]);
        if (!_timestate) {
            if(totalSeconds/60>0){
                _totalTime.text=[NSString stringWithFormat:@"%d:%02d",totalSeconds/60,totalSeconds%60];
                _timestate=YES;
            }
        }
        _slider.value = (CGFloat)seconds/totalSeconds;
    }
}
- (IBAction)sliderPanned:(id)sender {
    UISlider *s=sender;
    CGFloat songlen=CMTimeGetSeconds([manager songLength]);
    int time=s.value*songlen;
    [manager seek:time];
}

-(void)startSong{
    [manager setSong:[song getSongTitle] url:[song getSongURL]];
}
-(void)stopSong{
    [manager stop];
    [self.navigationController popViewControllerAnimated:true  ];
}
- (IBAction)playButtonClick:(id)sender {
    if ([manager isLoaded]){
        [manager toggleSong];
        if(manager.state==STATEPAUSED){
            [playButton setImage:playImage forState:UIControlStateNormal];
        }else{
            [playButton setImage:pauseImage forState:UIControlStateNormal];
            
        }
    }
}
@end
