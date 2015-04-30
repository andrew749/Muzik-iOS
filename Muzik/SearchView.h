//
//  SearchView.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-04-29.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
