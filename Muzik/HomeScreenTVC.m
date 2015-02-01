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
    NSMutableArray *array=[self getElements];
}
-(NSMutableArray *)getElements{
    NSURL*sUrl=[NSURL URLWithString:@"muzik-api.herokuapp.com/search"];
    NSMutableArray *elements=[[NSMutableArray alloc]init];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:sUrl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
//    while (condition) {
//        statements
//    
//    NSString*sName;
//    [elements addObject:[[SongEntry alloc] initSongEntry:sName withURL:sUrl]];
//    }
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
