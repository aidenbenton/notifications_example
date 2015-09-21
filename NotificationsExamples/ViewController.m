//
//  ViewController.m
//  NotificationsExamples
//
//  Created by Aiden Benton on 18/09/15.
//  Copyright (c) 2015 Maxwell Forest. All rights reserved.
//


#import "ViewController.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "NSObject+MFLSelectorSubscription.h"
#import "NotificationManager.h"

@import UIKit;

@interface ViewController ()

@property (nonatomic, readonly) NotificationManager *notificationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *notificationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    notificationButton.backgroundColor = [UIColor whiteColor];
    [notificationButton setTitle:@"Show me what you got!" forState:UIControlStateNormal];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giant_head"]];

    // Hierarchy

    [self.view addSubview:imageView];
    [self.view addSubview:notificationButton];

    // Layout

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [notificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

    // Bindings

    RACSignal *touchSignal = [notificationButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [NotificationManager mfl_subscribeSelector:@selector(scheduleNotification) toSignal:touchSignal];
}

@end