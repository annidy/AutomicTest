//
//  MyTimer.h
//  AutomicTest
//
//  Created by annidy on 2017/11/29.
//  Copyright © 2017年 annidy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTimer: NSObject

@property (nonatomic, strong) dispatch_source_t timer;

- (void)setNew;
- (void)fire;

@end

