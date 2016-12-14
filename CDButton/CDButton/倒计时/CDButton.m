//
//  CDButton.m
//  Choose
//
//  Created by George on 2016/12/14.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//  原文: http://code.cocoachina.com/view/133661

#import "CDButton.h"

@interface CDButton ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CDButton
static NSInteger count = 60;


+(instancetype)button {
    CDButton *btn = [CDButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.titleLabel.font = font(14);
    [btn setTitleColor:colorWithRGB(0x333333) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(timerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//方法一、
#pragma mark - 定时器⏲ 倒计时
-(void)timerAction:(CDButton *)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:@{@"btn":sender} repeats:YES];
}

-(void)countDown:(NSTimer *)timer {
    UIButton *btn = timer.userInfo[@"btn"];
    [btn setUserInteractionEnabled:NO];
    count--;
    [btn setTitle:[NSString stringWithFormat:@"%lds", (long)count] forState:UIControlStateNormal];
    
    if (count == 0) {
        count = 60;
        [btn setTitle:@"重新发送" forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:YES];
        [timer invalidate];
        timer = nil;
    }
}

//方法二、
#pragma mark - GCD 倒计时
-(void)GCDAction:(CDButton *)sender {
    
    [sender setUserInteractionEnabled:NO];
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeout == 0) {
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setUserInteractionEnabled:YES];
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
            });
            
        } else {
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%ds", timeout] forState:UIControlStateNormal];
            });
        }
        
    });
    dispatch_resume(timer);
}



@end
