//
//  Player.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-06.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "Player.h"
@import AVFoundation;
@implementation Player
@synthesize song;
@synthesize songLabel;
AVPlayer* songPlayer;

-(void)viewDidLoad{
    [super viewDidLoad];
    [songLabel setText:[song getSongTitle]];
    
}
-(void)playSongWithURL:(NSURL* ) url{
    NSError * error;
    songPlayer = [[AVPlayer alloc]initWithURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[songPlayer currentItem]];
    [songPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
}
-(void)switchSong{
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == songPlayer && [keyPath isEqualToString:@"status"]) {
        if (songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [songPlayer play];
            
            
        } else if (songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}
- (IBAction)playButtonClick:(id)sender {
    [self playSongWithURL:[song getSongURL ]];
}
@end
