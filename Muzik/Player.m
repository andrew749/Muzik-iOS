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
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong,readwrite)NSTimer* timer;
@end
@implementation Player
@synthesize song;
@synthesize songLabel;
@synthesize playButton;
@synthesize state;
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
    self.state=NOT_PLAYING;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateBar) userInfo:nil repeats:YES];
}
-(void)updateBar{
    CGFloat seconds=CMTimeGetSeconds([manager getTime]);
    _slider.value=seconds/CMTimeGetSeconds([manager songLength]);
}
- (IBAction)sliderPanned:(id)sender {
    UISlider *s=sender;
    CGFloat songlen=CMTimeGetSeconds([manager songLength]);
    int time=s.value*songlen;
    [manager seek:time];
}

-(void)playSongWithURL:(NSURL* ) url{
    [manager setSong:[song getSongTitle] url:[song getSongURL]];
    state=PLAYING;
}

-(void)pauseSong{
    [manager pause];
    self.state=PAUSED;
}
-(void)resumeSong{
    [manager play];
    self.state=PLAYING;
}
-(void)stopSong{
    [manager stop];
    [self.navigationController popViewControllerAnimated:true  ];
    self.state=STOPPED;
}
- (IBAction)playButtonClick:(id)sender {
    if(self.state==NOT_PLAYING){
        [self playSongWithURL:[song getSongURL]];
        [playButton setImage:pauseImage forState:UIControlStateNormal];
    }
    else if (self.state==PAUSED){
        [self resumeSong];
        [playButton setImage:pauseImage forState:UIControlStateNormal];
        
    }
    else if (self.state==PLAYING){
        [self pauseSong];
        [playButton setImage:playImage forState:UIControlStateNormal];
        
    }
}
@end
