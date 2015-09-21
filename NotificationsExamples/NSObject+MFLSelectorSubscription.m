//
// Created by Daniel Rodrigues on 25/09/2014.
// Copyright (c) 2014 Maxwell Forest. All rights reserved.
//

#import "NSObject+MFLSelectorSubscription.h"
#import "NSInvocation+RACTypeParsing.h"
#import "ReactiveCocoa.h"


@implementation NSObject (MFLSelectorSubscription)

- (RACSignal *)mfl_subscribeSelector:(SEL)selector toSignal:(RACSignal *)signal {
    @weakify(self);

    return [[[signal
            takeUntil:self.rac_willDeallocSignal]
            map:^RACSignal *(id _) {
                @strongify(self);
                NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                invocation.selector = selector;
                [invocation invokeWithTarget:self];

                return [invocation rac_returnValue];
            }]
            replayLast];
}

@end
