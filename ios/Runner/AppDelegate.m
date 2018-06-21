#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <EShare/EShare.h>
#import <objc/runtime.h>


@interface AppDelegate()
@property (nonatomic,strong)FlutterViewController *controller;
@property (nonatomic,copy)void (^deviceBlock)(NSArray *devicesArray);
@property (nonatomic,strong)NSArray *deviceArray;
@property (strong, nonatomic)NSString *transHttp;
@property (strong, nonatomic)ESHttpManage *httpManager;
@property (nonatomic,strong)ESDevice *connectedDevice;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    self.controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"GET_DEVICE_CHANNEL"
                                            binaryMessenger:self.controller];
    __weak __typeof__(self) weakSelf = self;
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        if ([call.method isEqualToString:@"GET_DEVICE_CHANNEL_Fx"])
        {
            strongSelf.deviceBlock = ^(NSArray *devicesArray) {
                
                self.deviceArray = devicesArray;
                NSMutableArray *devicesDicArray = [NSMutableArray array];
                NSString *jsonStringArr = @"";
                //这里做json字符串处理
                for (ESDevice *device in devicesArray)
                {
                    NSMutableDictionary *dic  = [self propertiesDic:device];
                    NSString *ip = [dic valueForKey:@"devicename"];
                    [dic setValue:ip forKey:@"a"];
                    NSLog(@"%@",dic);
                    [devicesDicArray addObject:dic];
                    NSData *data=[NSJSONSerialization dataWithJSONObject:devicesDicArray options:NSJSONWritingPrettyPrinted error:nil];
                    jsonStringArr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                    NSLog(@"%@",jsonStr);
                }
                result(jsonStringArr);
            };
            [strongSelf getDevice];
            
        }
        else if ([call.method isEqualToString:@"GET_DEVICE_CHANNEL_TRYTOCONNECT"])
        {
            NSDictionary *dic = call.arguments;
            NSString *deviceDicString = [dic valueForKey:@"date"];
            
            for (ESDevice *device in self.deviceArray)
            {
                if ([deviceDicString containsString:device.devicename])
                {
                    [ESDeviceCommand connectDevice:device];
                    self.connectedDevice = device;
                    result(@"ok");
                    break;
                }
            }
        }
        else if ([call.method isEqualToString:@"GET_DEVICE_CHANNEL_FILE"])
        {
            NSString *fileNamePath;
            NSDictionary *dic = call.arguments;
            NSString *deviceDicString = [dic valueForKey:@"date"];
            
            if ([deviceDicString.lowercaseString containsString:@"mp3"])
            {
                [ESLocalFileCommand OpenFile:fileNamePath fileType:kFileTypeAudio];
            }else if ([deviceDicString.lowercaseString containsString:@"mp4"])
            {
                [ESLocalFileCommand OpenFile:fileNamePath fileType:kFileTypeVideo];
            }else if ([deviceDicString.lowercaseString containsString:@"iostrans"])
            {
                NSLog(@"打开文件传送");
                NSString *httpTransString = [self startFileTrans];
                UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"打开文件传送" message:httpTransString preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertViewController addAction:cancleAction];
                 [self.controller presentViewController:alertViewController animated:YES completion:nil];
                
            }else{
                //直接打开文件
                 [ESLocalFileCommand OpenFile:fileNamePath fileType:kFileTypeOther];
            }
            NSString *jsonStringArr = @"";
            NSMutableArray *devicesDicArray = [NSMutableArray array];
            NSMutableDictionary *filedic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"test111",@"name",@"test2222",@"path",nil];
            [devicesDicArray addObject:filedic];
            NSData *data=[NSJSONSerialization dataWithJSONObject:devicesDicArray options:NSJSONWritingPrettyPrinted error:nil];
            jsonStringArr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            result(jsonStringArr);
        }
        else if ([call.method isEqualToString:@"SHOWFILE"])
        {
            result(FlutterMethodNotImplemented);
        }
        else
        {
            result(FlutterMethodNotImplemented);
        }
    }];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self _adStopThings];
}

#pragma mark - 处理程序崩溃时的回调动作
- (void)_adStopThings
{

    ESDevice * dev = self.connectedDevice;
    if (dev)
    {
        [ESDeviceCommand disconnectDevice:YES cb:nil];
    }
}

void UncaughtExceptionHandler(NSException *exception) {
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app _adStopThings];
}

- (void)getDevice
{
    [[ESDeviceCommand sharedESDeviceCommand] getDeviceList:^(NSArray *deviceAry) {
        
        if (self.deviceBlock)
        {
            self.deviceBlock(deviceAry);
        }
    }];
}


- (void)_cmCloudCastDidConnect:(NSNotification*)notify {
    NSLog(@"%@", notify);
    
    [ESDeviceCommand sayHello:TYPE_IPHONE];
    [[ESDeviceCommand sharedESDeviceCommand] startChectACK];
}

- (void)_cmAckTimeoutNotice:(NSNotification*)notify {
    NSLog(@"%@", notify);
    self.connectedDevice = nil;
    [self disconnectDevice:nil];
}

//断开棒子连接
- (void)disconnectDevice:(dispatch_block_t)successBlock
{
    [[ESDeviceCommand sharedESDeviceCommand] stopChectACK];
    [ESDeviceCommand disconnectDevice:YES cb:^(BOOL finish) {
            NSLog(@"断开设备连接");
    self.transHttp = @"";
    self.connectedDevice = nil;
    if (successBlock)
    {
        successBlock();
    }
        }];
}


#pragma mark - setting
- (ESHttpManage *)httpManager
{
    if (!_httpManager) _httpManager = [[ESHttpManage alloc] init];
    return _httpManager;
}

//启动文件传送
- (NSString *)startFileTrans
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _adInitSavePath];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_cmCloudCastDidConnect:) name:TcpSocketdidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_cmAckTimeoutNotice:) name:ACKTimeOutNotification object:nil];
    [[self httpManager] startHttpServer];
    [[ESDeviceCommand sharedESDeviceCommand] setReciveBordCastTime:120.0f];
    
    NSString *httpAdd = [Global getHttpAddress];
    return httpAdd;
}

-(void)_adInitSavePath
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [documentPaths objectAtIndex:0];
    NSString *workpath=[[NSString alloc] initWithFormat:@"%@/EShareFile",docDir];
    [Global initMountPath:workpath];
    NSString *ituneMusicPath = [[NSString alloc] initWithFormat:@"%@/.music",workpath];
    [Global initItunePath:ituneMusicPath];
    NSString *cameraPhotosPath = [[NSString alloc] initWithFormat:@"%@/.photo",workpath];
    [Global initCameraPhotosPath:cameraPhotosPath];
    NSString *cameraVideoPath = [[NSString alloc] initWithFormat:@"%@/.video",workpath];
    [Global initCameraVideoPath:cameraVideoPath];
    NSString *cachePhotoPath = [[NSString alloc] initWithFormat:@"%@/.cache",workpath];
    [Global initCachePhotosPath:cachePhotoPath];
    NSString *cameraCacheVideoPath  = [[NSString alloc] initWithFormat:@"%@/.cache_video",workpath];
    [Global initCameraCacheVideoPath:cameraCacheVideoPath ];
    NSString *webPath = [[NSString alloc] initWithFormat:@"%@/.eshareWeb",workpath];
    [Global copyWebFiles:webPath];
    NSString * name = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [[ESWebPage sharedESWebPage] setCompanyTitle:name];
    [[ESWebPage sharedESWebPage] setNetTitle:name];
}


#pragma mark - modelToDictionary
//Model 到字典
- (NSMutableDictionary *)propertiesDic:(NSObject *)obj
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


@end
