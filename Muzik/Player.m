//
//  Player.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-06.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "Player.h"
#import "Muzik-Swift.h"
@import AVFoundation;
@implementation Player
@synthesize song;
@synthesize state;
@synthesize songLabel;
@synthesize playButton;
AVPlayer* songPlayer;
MusicManager* manager;
- (IBAction)stopClick:(id)sender {
    [self stopSong];
}

state=NOT_PLAYING;
-(void)viewDidLoad{
    [super viewDidLoad];
    [songLabel setText:[song getSongTitle]];
   
}
-(void)playSongWithURL:(NSURL* ) url{
    manager=[MusicManager getObjInstance];
    [manager setSong:[song getSongTitle] url:[song getSongURL]];
    //    if(!songPlayer)
//        songPlayer= [[AVPlayer alloc]initWithURL:url];
//    [songPlayer play];
}
-(void)switchSong{
    
    
}

-(void)pauseSong{
    [manager pause];
//    [songPlayer pause];
    state=PAUSED;
}
-(void)resumeSong{
    [manager play];
//    [songPlayer play];
    state=PLAYING;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == songPlayer && [keyPath isEqualToString:@"status"]) {
        if (songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [songPlayer play];
            state=PLAYING;
            
        } else if (songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}
-(void)stopSong{
    [manager stop];
//    [songPlayer pause];
    [self.navigationController popViewControllerAnimated:true  ];
}
- (IBAction)playButtonClick:(id)sender {
    if(state==NOT_PLAYING){
        [self playSongWithURL:[song getSongURL]];
        [playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else if (state==PAUSED){
        [self resumeSong];
        [playButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
    else if (state==PLAYING){
        [self pauseSong];
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
        
    }
}
@end
