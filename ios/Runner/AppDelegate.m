#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <EShare/EShare.h>

@interface AppDelegate()
@property (nonatomic,strong)FlutterViewController* controller;
@property (nonatomic,copy)void (^deviceBlock)(NSArray *devicesArray);
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    self.controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"GET_DEVICE_CHANNEL"
                                            binaryMessenger:self.controller];
    
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
        
        if ([call.method isEqualToString:@"GET_DEVICE_CHANNEL_Fx"])
        {
            self.deviceBlock = ^(NSArray *devicesArray) {
                result(devicesArray);
            };
            [self getDevice];
            

        }
        else if ([call.method isEqualToString:@"GET_DEVICE_CHANNEL_TRYTOCONNECT"])
        {
            result(nil);
        }
        else if ([call.method isEqualToString:@"GET_DEVICE_CHANNEL_FILE"])
        {
            result(nil);
        }
        else if ([call.method isEqualToString:@"SHOWFILE"])
        {
            result(nil);
        }
        else
        {
            result(FlutterMethodNotImplemented);
        }
    }];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
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


@end
