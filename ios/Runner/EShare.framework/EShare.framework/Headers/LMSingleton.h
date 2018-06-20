
//
//  LMsingleton.h
//  LMOCPublicClass
//
//  Created by EShare on 16/6/29.
//  Copyright © 2016年 Eshare. All rights reserved.

//  宏定义单例 创建单例对象
// 导入头文件 .h中调用LMSingletonH(name)  .m中调用LMSingletonM(name)

// .h文件
#define LMSingletonH(name) + (instancetype)shared##name;

// .m文件
#define LMSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}