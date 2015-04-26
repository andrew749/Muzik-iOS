//
//  SongEntry.m
//  Muzik
//
//  Created by Andrew Codispoti on 2015-01-31.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import "Song.h"

@implementation Song
-(id)initSongEntry:(NSString *)songName{
    _songTitle=songName;
    return self;
}
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
    if(image!=nil)
    self.image=image;
}
-(void)setArtistName:(NSString *)artistName{
    self.artistName=artistName;
}
-(void) addSongUrl:(NSURL *)songUrl{
    self.songUrl=songUrl;
}
-(NSString *)getSongTitle{
    return self.songTitle;
}
-(NSURL *)getSongURL{
    return self.songUrl;
}
@end
