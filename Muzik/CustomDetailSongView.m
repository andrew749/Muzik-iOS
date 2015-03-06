//
//  CustomDetailSongView.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "CustomDetailSongView.h"
#import "Song.h"
@implementation CustomDetailSongView
@synthesize songName;
@synthesize song_Label;

-(void)viewDidLoad{
    [super viewDidLoad];
    [song_Label setText:songName];
}

@end
