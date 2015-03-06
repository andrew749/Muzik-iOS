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
@synthesize song;
@synthesize song_Label;

-(void)viewDidLoad{
    [super viewDidLoad];
    [song_Label setText:[song getSongTitle]];
}
-(NSMutableArray *)getLinks:(NSString *)songName{
    NSMutableArray* names=[[NSMutableArray alloc] init];
    NSString * baseurl=@"http://muzik-api.herokuapp.com/search?songname=";
    NSString * encodedName=[songName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * finalUrl=[NSString stringWithFormat:baseurl,encodedName];
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
@end
