//
//  FileModel.h
//  cloudcast
//
//  Created by EShare on 2016/12/27.
//  Copyright © 2016年 Eshare. All rights reserved.
// 文件共享模型

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property(nonatomic,assign) FileType fileType;
@property(nonatomic,copy)NSString * fileName; // 文件名
@property(nonatomic,copy)NSString * explain; // 扩展
@property(nonatomic,assign)NSInteger fileNum ;
@property(nonatomic,copy)NSString * filePath ; // 文件的全路径


@end
