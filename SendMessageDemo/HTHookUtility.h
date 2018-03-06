//
//  HTHookUtility.h
//  SendMessageDemo
//
//  Created by EGO on 2018/3/5.
//  Copyright © 2018年 zht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTHookUtility : NSObject
+(void)swizzlingInClass:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector;
@end
