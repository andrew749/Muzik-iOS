//
//  HomeScreenTVC.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-02-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "HomeScreenTVC.h"
#import "SongEntry.h"
@implementation HomeScreenTVC
@synthesize entries;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [entries count];
}
-(void) awakeFromNib{
    entries=[self getElements];
}
-(NSMutableArray *)getElements{
    NSMutableArray *elements=[[NSMutableArray alloc]init];
    

    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://muzik-api.herokuapp.com/top"]];
    NSArray* array = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:NSJSONReadingMutableLeaves
                          error:nil];
    NSDictionary *json=[array objectAtIndex:0];
    for(id key in json){
    NSString *sName=[json objectForKey:key];
    [elements addObject:[[SongEntry alloc] initSongEntry:sName ]];
    }
    return elements;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homeentry" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeentry"];
    }
    SongEntry *entry=entries[indexPath.row];
    cell.textLabel.text=entry.songTitle;
    cell.imageView.image=entry.image;
    return cell;
}
@end
