//
//  SongEntry.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-01-31.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface Song : NSObject
//holds the properties for a song
@property (nonatomic, strong)NSString *songTitle;
@property (nonatomic, strong)NSString *artistName;
@property  (nonatomic,strong)NSURL *songUrl;
@property (nonatomic,strong)UIImage *image;
//constructor for the songentry object.
-(id)initSongEntry:(NSString *) songName withURL:(NSURL *) url;
-(id)initSongEntry:(NSString *)songName;
-(NSString *)getSongTitle;

@end
