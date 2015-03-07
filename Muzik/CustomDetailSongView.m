//
//  CustomDetailSongView.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "CustomDetailSongView.h"
#import "Song.h"
@import AVFoundation;
@implementation CustomDetailSongView
@synthesize song;
@synthesize song_Label;
@synthesize resultsTable;


AVPlayer* songPlayer;

NSMutableArray * songs;
-(void)viewDidLoad{
    [super viewDidLoad];
    [song_Label setText:[song getSongTitle]];
    songs=[[NSMutableArray alloc] init ];
    songs=[self getLinks:[song getSongTitle]];
    NSLog(@"got songs");
    [resultsTable setDelegate:self];
    [resultsTable reloadData];
    NSLog(@"done reloading data");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[songs count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"urlcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [[[songs objectAtIndex:indexPath.row] getSongURL] absoluteString];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Song *song=[songs objectAtIndex:indexPath.row];
    NSURL* url=[song getSongURL];
    //check to see if the url exists
    if(song)
    if(![[url absoluteString] isEqualToString:@""]){
        [self playSongWithURL:url];
    }
}
-(void)viewDidLayoutSubviews{
    song_Label.preferredMaxLayoutWidth=song_Label.frame.size.width;
}
-(NSMutableArray *)getLinks:(NSString *)songName{
    NSMutableArray* names=[[NSMutableArray alloc] init];
    NSString * baseurl=@"http://muzik-api.herokuapp.com/search?songname=";
    NSString * encodedName=[songName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * finalUrl=[NSString stringWithFormat:@"%@%@",baseurl,encodedName];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalUrl]];
    NSArray* array = [NSJSONSerialization
                      JSONObjectWithData:data //1
                      
                      options:NSJSONReadingMutableLeaves
                      error:nil];
    for(id element in array){
        NSString *sName=element[@"title"];
        [names addObject:[[Song alloc] initSongEntry:sName withURL:[NSURL URLWithString:element[@"url"]]]];
    }

    return names;
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
@end
