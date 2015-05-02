//
//  MusicManager.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-05-02.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicManager : NSObject
@property  (nonatomic,strong)NSString
@property(nonatomic,retain)AVPlayer * player;
+(MusicManager*)getInstance();
@end
