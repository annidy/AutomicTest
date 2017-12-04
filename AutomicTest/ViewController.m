//
//  ViewController.m
//  AutomicTest
//
//  Created by annidy on 2017/11/29.
//  Copyright © 2017年 annidy. All rights reserved.
//

#import "ViewController.h"
#import "MyTimer.h"

@interface ViewController ()

@end

@implementation ViewController {
    MyTimer *_myTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _myTimer = [MyTimer new];
    [_myTimer fire];
    [self run];
    [self run];
}

- (void)run {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self run];
        usleep(10*1000);
    });
    [_myTimer setNew];
}


@end
