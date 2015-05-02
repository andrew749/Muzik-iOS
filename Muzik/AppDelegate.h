//
//  AppDelegate.h
//  Muzik
//
//  Created by Andrew Codispoti on 2015-01-31.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic)AVPlayer *player;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

