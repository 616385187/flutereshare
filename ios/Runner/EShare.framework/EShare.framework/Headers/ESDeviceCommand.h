//
//  ESDeviceCommand.h
//  EShare
//
//  Created by EShare on 16/7/16.
//  Copyright © 2016年 eshare. All rights reserved.


/**
 *  udp通讯
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LMSingleton.h"
#import "ESResultCode.h"

// 设备连接成功通知
extern NSString *const TcpSocketdidConnectNotification ;

// 设备连接断开成功通知
extern NSString *const TcpSocketdidDisconnectNotification ;

// 断开tcp连接通知 (调用[asyncSocket disconnect]发出此通知)
extern NSString *const DisconnectTcpSocketNotification ;

// 心跳接收时间超时通知
extern NSString *const ACKTimeOutNotification ;

@class ESDevice ;


@interface ESDeviceCommand : NSObject


// 单例对象
LMSingletonH(ESDeviceCommand)

@property(nonatomic,assign)double reciveBordCastTime; // 设备接上次收到广播的时间
/**
*  获取设备列表
*  @param deviceListCb    返回设备列表
*/
-(void)getDeviceList:(void (^)(NSArray * deviceAry))deviceListCb ;

/**
 *  连接设备
 */
+(void)connectDevice:(ESDevice *)device ;

/**
 重连设备
 */
+(void)reconnectDevice;

/**
 断开设备连接
 
 @param sayByeBye 是否要TV端显示设备断开连接
 @param finishCb cb
 */
+(void)disconnectDevice:(BOOL)sayByeBye cb:(void (^)(BOOL finish))finishCb;

/**
 *  终端设备上提示某设备断开连接了
 */
+(void)sayByeBye;
// #define

/**
 终端设备上提示某设备连接了

 @param devTYpe TYPE_IPAD,TYPE_IPHONE
 */
+(void)sayHello:(NSInteger)devTYpe ;



#pragma mark -- 镜像
/**
 *  开始解析反向屏幕镜像
 */
+(void)startMirror:(void (^)(UIImage * data))screenImgCb;

/**
 *  停止解析反向镜像
 */
+(void)stopMirror;

#pragma mark -- 心跳
/**
 检测心跳
 */
-(void)startChectACK;

/**
 停止检测心跳
 */
-(void)stopChectACK;


@end
