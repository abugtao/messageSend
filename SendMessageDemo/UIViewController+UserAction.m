//
//  UIViewController+UserAction.m
//  SendMessageDemo
//
//  Created by EGO on 2018/3/5.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "UIViewController+UserAction.h"
#import "HTHookUtility.h"
@implementation UIViewController (UserAction)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(ht_viewWillAppear:);
        [HTHookUtility swizzlingInClass:[self class] originSelector:originalSelector swizzledSelector:swizzledSelector];
        
        
        SEL originalSelector2 = @selector(viewDidDisappear:);
        SEL swizzledSelector2 = @selector(ht_viewDidDisappear:);
        [HTHookUtility swizzlingInClass:[self class] originSelector:originalSelector2 swizzledSelector:swizzledSelector2];
        
    });
}


- (void)ht_viewWillAppear:(BOOL)animated{
    [self action_viewWillApper]; //插入代码
    [self ht_viewWillAppear:animated];
}


- (void)ht_viewDidDisappear:(BOOL)animated{
    [self action_viewDidDisappear];  //插入代码
    [self ht_viewDidDisappear:animated];
}



- (void)action_viewWillApper{
    NSString *pageId = [self pageEventID:YES];
    
    if (pageId) {
        //发送
    }
    
    
}

- (void)action_viewDidDisappear{
    NSString *pageId = [self pageEventID:NO];
    if (pageId) {
        //发送
    }
    
    
}

- (NSString *)pageEventID:(BOOL)enter{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UserAction" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *className = NSStringFromClass([self class]);
    
    return dic[className][@"PageEventIDs"][enter?@"Enter":@"Leave"];
    
    
    
}



@end
