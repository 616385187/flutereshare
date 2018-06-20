//
//  VideoAssetsPicker.h
//  EShareCVT
//
//  Created by EShare on 15/10/18.
//  Copyright © 2015年 XuMac. All rights reserved.

//  本地视频导出

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface VideoAssetsPicker : NSObject

+(VideoAssetsPicker*)defaultPicker;

// 视屏导出
-(void)fetchVideo:(PHAsset *)asset completion:(void (^)(PHAsset *asset, BOOL success ))completion  progress:(void (^)(PHAsset *asset, int  percent ))progress;
// 停止视屏导出
-(void)stopFetchVideos;



@end
