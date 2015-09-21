//
//  AppDelegate.m
//  NotificationsExamples
//
//  Created by Aiden Benton on 18/09/15.
//  Copyright (c) 2015 Maxwell Forest. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NotificationManager.h"

@implementation AppDelegate

static NSString * const kShwiftyString = @"http://www.youtube.com/watch?v=4ctK1aoWuqY";
static NSString * const kNukesString = @"http://www.youtube.com/watch?v=negNvaEwZJs";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
    }

    [NotificationManager setupNotificationSettings];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    if ([identifier isEqualToString:kNotificationActionShwifty]) {
        [NotificationManager playVideo:kShwiftyString];
    } else {
        [NotificationManager playVideo:kNukesString];
    }
    completionHandler();
}

@end