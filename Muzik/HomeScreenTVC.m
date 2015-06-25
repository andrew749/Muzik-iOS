
//  HomeScreenTVC.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-02-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "HomeScreenTVC.h"
#import "Song.h"
#import "CustomDetailSongView.h"
#import "Muzik-Swift.h"
@interface HomeScreenTVC()
@property (strong,readwrite)UIImage* defaultPlaceholder;
@end
@implementation HomeScreenTVC
@synthesize entries;
@synthesize defaultPlaceholder=_defaultPlaceholder;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [entries count];
}
-(void) awakeFromNib{
    entries=[self getElements];
}
-(void) viewDidLoad{
    self.tableView.rowHeight=160;
}
-(void)viewDidAppear:(BOOL)animated{
    if ([[MusicManager getObjInstance] isLoaded]){
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"Now Playing" style:UIBarButtonItemStylePlain target:self action:@selector(goToPlayer)];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    }
}
-(void)goToPlayer{
    
}
-(void)setDefaultPlaceholder:(UIImage *)defaultPlaceholder{
    self.defaultPlaceholder=defaultPlaceholder;
}
-(UIImage *)defaultPlaceholder{
    if(_defaultPlaceholder==nil)
    {
        UIImage* tempImage=[UIImage imageNamed:@"musicimage.png"];
        _defaultPlaceholder=tempImage;
    }
    return _defaultPlaceholder;
}
-(NSMutableArray *)getElements{
    NSMutableArray *elements=[[NSMutableArray alloc]init];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://muzik-api.herokuapp.com/top"]];
    NSArray* array = [NSJSONSerialization
                      JSONObjectWithData:data //1
                      options:NSJSONReadingMutableLeaves
                      error:nil];
    int count=0;
    for(id element in array){
        if(count++<=25){
            NSString *sName=element[@"title"];
            NSURL* url=nil;
            url=[NSURL URLWithString:element[@"albumArt"]];
            [elements addObject:[[Song alloc] initSongEntry:sName withURL:url]];
        }
    }
    return elements;
}
//method to be implemented which plays the song

-(void)loadImage:(Song *)entry forImageView:(UIImageView *)imageView{
    if(![[entry getSongURL] isKindOfClass:[NSNull class]])
        if(entry.image==nil){
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[entry getSongURL].absoluteString]];
                UIImage* tempImage=[UIImage imageWithData:data];
                if(tempImage!=nil){
                    entry.image=tempImage;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Your code to run on the main queue/thread
                        imageView.image=entry.image;
                    });
                }
                
            });
        }
        else{
            imageView.image=entry.image;
        }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homeentry" forIndexPath:indexPath];
    tableView.rowHeight = UITableViewAutomaticDimension;
    Song *entry=entries[indexPath.row];
    UILabel *name=(UILabel *)[cell.contentView viewWithTag:1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeentry"];
    }
    UIImageView *iv=[cell viewWithTag:2];
    iv.image=self.defaultPlaceholder;
    [self loadImage:entry forImageView:(UIImageView *)[cell viewWithTag:2]];
    name.text=entry.songTitle;
    return cell;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //if the sender is the songdetail
    if([segue.identifier isEqualToString:@"songdetail"]){
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        CustomDetailSongView *controller=segue.destinationViewController;
        controller.song=(Song *)[entries objectAtIndex:indexPath.row];
    }
}
@end
