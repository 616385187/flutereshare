//
//  AirplayManage.h
//  EShare
//
//  Created by EShare on 16/4/11.
//  Copyright © 2016年 eshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMSingleton.h"
typedef NS_ENUM(NSUInteger, AirPlayConnectStaus) {
    AirPlayConnectStausFail = 0 , 
    AirPlayConnectStausSuc,
    AirPlayConnectStausConnecting, // airplay已经连接着（处于连接了的状态）
    
};

@interface AirplayManage : NSObject

LMSingletonH(AirplayManage)

// airplay是否连接中
@property(nonatomic,assign)BOOL airPlayIsConnect;

// airplay连接断开回调
@property(nonatomic,copy)void(^disConnectAirplayCb)(BOOL disConnect);


/**
 开始投频
 @param connectCb result=1 连接成功 其他连接失败
 */

-(void)startAirplay:(NSString *)devName pwd:(NSString *)pwd Cb:(void (^)(AirPlayConnectStaus result))connectCb ;


/**
 结束投频
 */
-(void)disconnectAirplay;



@end
