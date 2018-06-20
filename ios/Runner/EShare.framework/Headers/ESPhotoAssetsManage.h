//
//  ESPhotoAssetsManage.h
//  EShare
//
//  Created by EShare on 16/7/20.
//  Copyright © 2016年 eshare. All rights reserved.


//  相册数据

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ESPhotoAssetsManage : NSObject


/**
 从asset中获取img 或者保存img

 @param asset phasset
 @param targetSize 终端显示尺寸
 @param needSave 是否需要保持图片到本地
 @param directory 相册的保存目录
 @param cb isDegraded 是否是高清图
 */
+(void)exportImg:(id)asset targetSize:(CGSize)targetSize needSave:(BOOL)needSave savePath:(NSString *)directory cb:(void (^)(BOOL isDegraded,UIImage * img))cb;




@end
