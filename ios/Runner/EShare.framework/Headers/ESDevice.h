//
//  ESDevice.h
//  EShare
//
//  Created by EShare on 16/7/18.
//  Copyright © 2016年 eshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESDevice : NSObject
// 设备的唯一标志
@property (nonatomic, retain) NSString *hostIp;
// 设备名称
@property (nonatomic, retain) NSString *devicename;
// 端口号
@property (nonatomic,assign) NSInteger port;

@property (nonatomic,assign) NSInteger server_features;

@property (nonatomic,assign) NSInteger fps;

// 设备连接密码
@property(nonatomic,copy)NSString * pwd ;

// 上次被找到的时间 (一分钟没找到则移除掉)
@property(nonatomic,assign)double lastFoundTime;


@end
