//
//  ESRemoteControlCommand.h
//  EShare
//
//  Created by EShare on 16/7/23.
//  Copyright © 2016年 eshare. All rights reserved.
//


/**
 *  遥控器功能
 */
#import <Foundation/Foundation.h>
@class CommandHandler;
@class  CMDeviceMotion;

@interface ESRemoteControlCommand : NSObject

typedef NS_ENUM(NSInteger, TouchesType) {
    TouchesTypeMirror,   //触摸控制
    TouchesTypeMouse , //鼠标控制
    TouchesTypeSlide ,  //滑动控制
    
};
typedef NS_ENUM(NSInteger, SlideDirection) {
    SlideDirectionDefault = -1,
    SlideDirectionH , //水平控制
    SlideDirectionV ,  // 竖直控制
};

/**
 *  功能按键
 *
 *  @param tag （ESCommandCode.h中）
 */

+(void)remoteControl:(NSInteger)tag;

/**
 *  功能按键 + 长按
 *
 *  @param tag （ESCommandCode.h中）
 */

+(void)remoteControl_Longpress:(int)tag;


#pragma mark -- 触摸控制  鼠标控制  

/**
 *  触摸开始
 *
 *  @param touches  touches
 *  @param direction  SlideDirection
 *  @param type TouchesType
 *  @param mirrorview  只有type=TouchesTypeMirror时此参数不为空
 *  @param comHandel  CommandHandler
 */
-(void)touchesBegan:(NSSet *)touches direction:(SlideDirection)direction type:(TouchesType)type  mirrorview:(UIView *)mirrorview commandHandler:(CommandHandler *)comHandel;


-(void)touchesMoved:(NSSet *)touches commandHandler:(CommandHandler *)comHandel;


-(void)touchesEnded:(NSSet *)touches commandHandler:(CommandHandler *)comHandel;

-(void)touchesCancelled:(NSSet *)touches commandHandler:(CommandHandler *)comHandel ;


#pragma mark -- 传感器（空中鼠标）

/**
 *  初始化传感器
 *
 *  @param moveToCentre 传感器是否移动到中心位置
 *  @param cb x,y坐标
 *
 */
-(instancetype)initMotion:(BOOL)moveToCentre cb:(void(^)(float x ,float y))cb ;
/**
 *  更新传感器数据
 *
 */

-(void)updataDataWith:(CMDeviceMotion *)currentDeviceMotion ;
/**
 发送传感器数据
 
 @param x x坐标
 @param y y坐标
 @param action 动作
 */
- (void)sendSensorData:(float)x y:(float)y action:(int)action;

/**
 *  传感器移动到中心位置
 */
-(void)moveToCentre ;


-(void)setAction:(int)action;


@end
