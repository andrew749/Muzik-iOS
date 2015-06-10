//
//  CustomDetailSongView.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-03-01.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
@interface CustomDetailSongView : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak,nonatomic) IBOutlet UILabel* song_Label;
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (strong,nonatomic)Song* song;
@end
