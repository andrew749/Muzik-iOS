//
//  CustomDetailSongView.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "CustomDetailSongView.h"
#import "Song.h"
#import "Player.h"
#import "Muzik-Swift.h"
@implementation CustomDetailSongView
@synthesize song;
@synthesize song_Label;
@synthesize resultsTable;
@synthesize albumImage;


NSMutableArray * songs;
-(void)viewDidLoad{
    [super viewDidLoad];
    [song_Label setText:[song getSongTitle]];
    songs=[[NSMutableArray alloc] init ];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.spinner startAnimating];
        [self getLinks:[song getSongTitle]];
    });
    albumImage.image=song.image;
    [resultsTable setDelegate:self];
    NSLog(@"done reloading data");
}
-(void)viewDidAppear:(BOOL)animated{
    if([[MusicManager getObjInstance] isLoaded]){
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Now Playing" style:UIBarButtonItemStylePlain target:self action:@selector(openPlayer)];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    }
}
-(void)openPlayer{
    [self performSegueWithIdentifier:@"playsong" sender:self];
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
    cell.textLabel.text = [[songs objectAtIndex:indexPath.row] getSongTitle];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"playsong" sender:nil];
}
-(void)viewDidLayoutSubviews{
    song_Label.preferredMaxLayoutWidth=song_Label.frame.size.width;
}
-(void)getLinks:(NSString *)songName{
    NSMutableArray* names=[[NSMutableArray alloc] init];
    NSString * baseurl=@"http://muzik-api.herokuapp.com/search?songname=";
    NSString * encodedName=[songName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * finalUrl=[NSString stringWithFormat:@"%@%@",baseurl,encodedName];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalUrl]];
    NSDictionary* jsondata = [NSJSONSerialization
                      JSONObjectWithData:data //1
                      
                      options:NSJSONReadingMutableLeaves
                      error:nil];
    NSArray* array=jsondata[@"url"];
    for(id element in array){
        for (NSString* key in element){
            @try {
                if (element[key]){
                    NSURL* url=[NSURL URLWithString:element[key]];
                    if(url)
                    [names addObject:[[Song alloc] initSongEntry:key withURL:url]];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }
    }
    
    songs=names;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.spinner stopAnimating];
        [resultsTable reloadData];
    });
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //if the sender is the songdetail
    if([segue.identifier isEqualToString:@"playsong"]){
        NSIndexPath *indexPath=[resultsTable indexPathForSelectedRow];
        Player *controller=segue.destinationViewController;
        controller.song=(Song *)[songs objectAtIndex:indexPath.row];
        controller.image=song.image;
    }
}

@end
