//
//  ESLocalFileCommand.h
//  EShare
//
//  Created by EShare on 16/7/19.
//  Copyright © 2016年 eshare. All rights reserved.

/**
 *  本地文件
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Constants.h"
@class PHAsset, FoldModel ;
@interface ESLocalFileCommand : NSObject

typedef NS_ENUM(int,FileOperationType){
    FileOperationTypeDelFile , //删除本地文件,文件夹
    FileOperationTypeAddFile , //增加文件(图片，文档，音，视频)
    FileOperationTypeAddFolder , // 增加文件夹
};

#pragma mark -- 图片

/**
 图片推送 （一次性推送三张图片）图片推送前要进行压缩，建议压缩尺寸为(1920, 1080)

 @param last 上一张图片地址的相对路径 (eg: 上一张图片绝对路径 = /var/mobile/Containers/Data/Application/5C3932AF-C1CB-4C64-9923-0231FAA4C7BB/Documents/EShareFile/.photo/IMG_0850.PNG, 那么last = /.photo/IMG_0850.PNG , 其中/var/mobile/Containers/Data/Application/5C3932AF-C1CB-4C64-9923-0231FAA4C7BB/Documents/EShareFile = [Global getMountPath])
 @param cur 当前图片地址的相对路径
 @param next 下一张图片地址的相对路径
 */

+(void)pushImg:(NSString *)last cur:(NSString *)cur nextImg:(NSString *)next;
/**
 *  退出图片推送 (终端设备返回推送图片之前的界面)
 */
+(void)imageControlFinish;
/**
 图片旋转

 @param rotation 90, -90
 */
+(void)imageRotation:(NSInteger)rotation;


#pragma mark -- 文件推送
/**
 *   推送文档，视频，音乐 (相对路径)
 *
 *  @param relativeFilePath 文件相对路径 eg:/IMG_0001.MOV
 *  @param fileType 文件类型
 */
+(void)OpenFile:(NSString *)relativeFilePath fileType:(FileType)fileType;

/**
 *  停止音乐,视频推送 （退出播放时调用）
 */
+(void)stopPushMedia;


/**
 *   获取音/视频总时长
 *
 *  @param Cb 视频时长多少毫秒
 */
+(void)getDurationTime:(void (^)(NSInteger second))Cb;


/**
 *  获取音/视频当前播放时间
 *
 *  @param Cb 当前播放到多少毫秒 （second = -2 当前音乐播放完成，second = -1 当前视屏播放完成）
 */
+(void)getCurrentTime:(void (^)(NSInteger second))Cb ;


/**
 *  暂停音/视屏播放
 */
+(void)pause ;

/**
 *  继续播放
 */
+(void)play;

/**
 *  当前音/视屏播放位置快进，快退到多少秒
 *
 *  @param time  单位秒
 */
+(void)seekTo:(NSInteger)time ;

#pragma mark -- 终端设备音量

/**
 *  获取终端设备的声音 (范围[0,30])
 *
 *  @param Cb 当前音量大小
 */
+(void)getCurrentVol:(void (^)(NSInteger data))Cb;

/**
 *  设置终端设备的声音 (范围[0,30])
 *
 *  @param vol 音量大小
 */
+(void)setVol:(NSInteger)vol;

#pragma mark -- 本地文件推送（文件随心传模块）

/**
 获取某个目录下的所有文件

 @param directoryPath 目录的绝对路径
 @return 该目录下的所有文件
 */
+(NSArray *)getAllfiles:(NSString *)directoryPath;
/**
 *  实时监听本地文件的增加删除通知
 */
-(void)addLocalFileNotificationCb:(void (^)(NSString * filePath,FileOperationType tag))localfileChangedCb;

-(void)deleteLocalFileNotification;

/**
 *  获取文件类型
 */
+(FileType)getFileType:(NSString*)fname;

// 获取文件互传中某种文件类型的所有文件夹
+(NSArray <FoldModel *> *)getFoldList:(FileType)fileType1;

/**
 增加文件夹

 @param path 文件绝对路径
 */
+(void)addFold:(NSString *)path ;


/**
 文件是否存在

 @param filePath 文件地址
 @return yes ,NO 
 */
+(BOOL)isFileExist:(NSString *)filePath;


/**
 *  图片缩放
 *
 */
+(void)imageScale:(float)scale :(float)dx :(float)dy ;




@end
