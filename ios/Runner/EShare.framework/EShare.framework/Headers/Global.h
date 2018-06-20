
#import <Foundation/Foundation.h>
#import  <AudioToolbox/AudioServices.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>




@interface Global : NSObject


typedef void(^ReciveDataCb)(NSData * data ,NSInteger tag);
@property(nonatomic,copy)ReciveDataCb reciveDataCb ;


+(instancetype)shareGlobal;

// <--- 存储数据地址 ------>
// 根目录
+ (void)initMountPath:(NSString*)path;
+ (NSString*)getMountPath;
// 音乐根目录
+(void)initItunePath:(NSString*)path;
+(NSString*)getItuneMusicPath;
// 图片根目录
+(void)initCameraPhotosPath:(NSString*)path;
+(NSString*)getCameraPhotosPath;
// 视频根目录
+(void)initCameraVideoPath:(NSString *)path;
+(NSString*)getCameraVideoPath;

// 缓存文件目录
+(void)initCachePhotosPath:(NSString *)path;
+(NSString*)getCachePhotosPath;
+(void)initCameraCacheVideoPath:(NSString *)path;
+(NSString*)getCameraCacheVideoPath;

// 清除缓存
+(void)clearData:(void(^)(NSInteger result))cb;

+(void)copyWebFiles:(NSString*)webPath;


/**
 应用的地址（浏览器中访问YLCloudCast的网址）
 @return 应用的地址
 */
+ (NSString*)getHttpAddress;


//+(void)addLog:(NSString *)str;



@end
