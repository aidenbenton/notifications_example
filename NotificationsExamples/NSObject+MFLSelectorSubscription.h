//
// Created by Daniel Rodrigues on 25/09/2014.
// Copyright (c) 2014 Maxwell Forest. All rights reserved.
//

@import Foundation;

@class RACSignal;

@interface NSObject (MFLSelectorSubscription)

- (RACSignal *)mfl_subscribeSelector:(SEL)selector toSignal:(RACSignal *)signal;

@end
