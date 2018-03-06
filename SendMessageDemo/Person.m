//
//  Person.m
//  SendMessageDemo
//
//  Created by zht on 2018/2/28.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "Person.h"
#import "MyPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation Person
//第一次机会: 所属类动态方法解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    
    /*
     ”v@:”意思就是这已是一个void类型的方法，没有参数传入。
     “i@:”就是说这是一个int类型的方法，没有参数传入。
     ”i@:@”就是说这是一个int类型的方法，又一个参数传入。
     */
    
//    if ([NSStringFromSelector(sel) isEqualToString:@"run"]) {
//        class_addMethod([self class], sel, class_getMethodImplementation(self, @selector(myrun)), "v@:");
    
//
//        //IMP 一个函数指针，指向我们定义的函数
//        //SEL 是方法编号    通过SEL找到IMP去执行函数
//        return YES;
//    }
    
    return [super resolveInstanceMethod:sel];
}


- (void)myrun{
    NSLog(@"runrun");
}


//第二次机会: 备援接收者
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"run:"]) {
//        return [[MyPerson alloc] init];
        return nil;
        
        
        
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

//第三次机会: 消息重定向     这里跟第二次机会效果一样   都是可以指定一个其他的对象来执行这个函数


//NSMethodSignature 方法签名   官方定义该类为对方法的参数、返回类似进行封装，协同NSInvocation实现消息转发。
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //生成一个签名返回 可以和SEL毫无关系
    if ([NSStringFromSelector(aSelector) isEqualToString:@"run:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return nil;
}
 //返回签名后调用此方法，在参数中已经存储了SEL信息，简易的异常处理，可提示所有类的非法方法调用，不崩溃。
//NSInvocation是一个消息调用类，它包含了所有OC消息的成分：target、selector、参数以及返回值。
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
    
    
    MyPerson *p = [[MyPerson alloc] init];
    if ([p respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:p];
    } else {
        [super forwardInvocation:anInvocation];
    }
    
    
    
//    NSString * key = NSStringFromSelector([anInvocation selector]);
//    NSLog(@"Class %@ can't responer %@ methond",[self class],key);
}



@end
