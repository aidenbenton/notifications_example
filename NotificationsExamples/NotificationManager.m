//
// Created by Aiden Benton on 18/09/15.
// Copyright (c) 2015 Maxwell Forest. All rights reserved.
//

#import "NotificationManager.h"
#import "ReactiveCocoa.h"

@import UIKit;

static NSString * const kNotificationCategoryGiantHead  = @"SHOW_ME_WHAT_YOU_GOT";

@implementation NotificationManager

+ (void)scheduleNotification {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Do something";
    localNotification.alertBody = @"Show me what you got.";
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:5];
    localNotification.category = kNotificationCategoryGiantHead;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+ (void)setupNotificationSettings {
    UIMutableUserNotificationAction *showMeAction = [NotificationManager showMeAction];
    UIMutableUserNotificationAction *cancelAction = [NotificationManager cancelAction];

    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = kNotificationCategoryGiantHead;
    [category setActions:@[showMeAction, cancelAction] forContext:UIUserNotificationActionContextMinimal];
    [category setActions:@[showMeAction, cancelAction] forContext:UIUserNotificationActionContextDefault];

    UIUserNotificationSettings * notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:[NSSet setWithArray:@[category]]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}

+ (UIMutableUserNotificationAction *)showMeAction {
    UIMutableUserNotificationAction *notificationAction = [[UIMutableUserNotificationAction alloc] init];
    notificationAction.identifier = kNotificationActionShwifty;
    notificationAction.title = @"Get Shwifty!";
    notificationAction.destructive = NO;
    notificationAction.authenticationRequired = NO;
    notificationAction.activationMode = UIUserNotificationActivationModeForeground;
    return notificationAction;
}

+ (UIMutableUserNotificationAction *)cancelAction {
    UIMutableUserNotificationAction *notificationAction = [[UIMutableUserNotificationAction alloc] init];
    notificationAction.identifier = kNotificationActionNukes;
    notificationAction.title = @"Nuke 'em!";
    notificationAction.destructive = YES;
    notificationAction.authenticationRequired = YES;
    notificationAction.activationMode = UIUserNotificationActivationModeForeground;
    return notificationAction;
}

+ (void)playVideo:(NSString *)urlString {
    [[[[NSNotificationCenter defaultCenter]
            rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil]
            take:1]
            subscribeNext:^(id x) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            }];
}

@end