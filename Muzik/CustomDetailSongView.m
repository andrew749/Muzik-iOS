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
@synthesize resultsTable;
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
@end
