//
//  SongEntry.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-01-31.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "SongEntry.h"

@implementation SongEntry
-(id)initSongEntry:(NSString *) songNameToInit withURL:(NSURL *) url{
    if(self=[super init]){
        _songTitle=songNameToInit;
        _songUrl=url;
    }
    return self;

}
-(void)setSongTitle:(NSString *)songTitle{
    self.songTitle=songTitle;
}
-(void)setImage:(UIImage *)image{
    self.image=image;
}
-(void)setArtistName:(NSString *)artistName{
    self.artistName=artistName;
}
-(void) setSongUrl:(NSURL *)songUrl{
    self.songUrl=songUrl;
}
@end
