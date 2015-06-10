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
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
- (IBAction)playButtonClick:(id)sender;
@property(strong,nonatomic)UIImage* image;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (strong, nonatomic)Song *song;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
typedef enum {NOT_PLAYING, PLAYING, PAUSED, STOPPED}STATE;
- (IBAction)stopClick:(id)sender;
@property STATE state;
@end
