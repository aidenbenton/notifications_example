//
// Created by Aiden Benton on 18/09/15.
// Copyright (c) 2015 Maxwell Forest. All rights reserved.
//

@import Foundation;

static NSString * const kNotificationActionShwifty = @"GET_SHWIFTY";
static NSString * const kNotificationActionNukes = @"NUKES";

@interface NotificationManager : NSObject

+ (void)setupNotificationSettings;
+ (void)scheduleNotification;
+ (void)playVideo:(NSString *)urlString;

@end