//
//  HTHookUtility.m
//  SendMessageDemo
//
//  Created by EGO on 2018/3/5.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "HTHookUtility.h"
#import <objc/runtime.h>
@implementation HTHookUtility

+(void)swizzlingInClass:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    
    //反馈yes 表示originSelector 没有实现          返回no表示originSelector有实现 可以直接交换
    BOOL didAddMethod =  class_addMethod(class, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    
    
}

@end
