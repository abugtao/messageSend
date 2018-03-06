//
//  UIControl+UserAction.m
//  SendMessageDemo
//
//  Created by EGO on 2018/3/5.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "UIControl+UserAction.h"
#import "HTHookUtility.h"
@implementation UIControl (UserAction)
+(void)load{
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL swizzledSelector = @selector(ht_sendAction:to:forEvent:);
    [HTHookUtility swizzlingInClass:[self class] originSelector:originalSelector swizzledSelector:swizzledSelector];
}



- (void)ht_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    [self dealUserAction:action to:target forEvent:event]; //处理统计
    [self ht_sendAction:action to:target forEvent:event];
}

- (void)dealUserAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UserAction" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *targetName = NSStringFromClass([target class]);
    
    NSString *eventId = dic[targetName][@"ControlEventIDs"][NSStringFromSelector(action)];
    
    NSLog(@"eventId = %@",eventId);
}

@end
