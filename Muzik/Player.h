//
//  Player.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-06.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
@interface Player : UIViewController
@property (strong, nonatomic)Song *song;
@end
