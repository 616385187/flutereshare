//
//  FoldModel.h
//  cloudcast
//
//  Created by EShare on 2016/12/29.
//  Copyright © 2016年 Eshare. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FileModel ;
@interface FoldModel : NSObject

@property(nonatomic,copy)NSString * docPath ; // 文件夹全路径
@property(nonatomic,copy)NSString * docName; // 文件夹名称

@property(nonatomic,strong)NSArray <FileModel *> * files; // 此目录下的文件

@property(nonatomic,assign)BOOL isClose ; // 是否允许打开

@end
