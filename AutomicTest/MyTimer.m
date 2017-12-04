//
//  MyTimer.m
//  AutomicTest
//
//  Created by annidy on 2017/11/29.
//  Copyright © 2017年 annidy. All rights reserved.
//

#import "MyTimer.h"


@interface MyTimer()
@property (atomic) NSObject *caller;
@end

@implementation MyTimer {
    
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupTimer];
    }
    return self;
}

- (void)setupTimer
{
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("MyTimer", 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf test];
    });
    self.timer = timer;
}

- (void)test {
    // 有很小几率读到脏数据
    [_caller hash];
}


- (void)setNew {
    // 多线程set导致重复释放和脏数据
    _caller = [NSObject new];
}

- (void)fire
{
    dispatch_resume(self.timer);
}

- (void)invalidate
{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        _timer = nil;
    }
}

@end
