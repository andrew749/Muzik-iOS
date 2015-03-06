//
//  CustomDetailSongView.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDetailSongView : UIViewController
@property (weak,nonatomic) IBOutlet UILabel* song_Label;
@property (strong,nonatomic)NSString* songName;
@end
