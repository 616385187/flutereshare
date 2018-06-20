//
//  LMMusic.h
//  cloudcast
//
//  Created by EShare on 2016/12/26.
//  Copyright © 2016年 Eshare. All rights reserved.


// public

#import <Foundation/Foundation.h>
#import "LMSingleton.h"
@interface LMMusic : NSObject

@property(nonatomic,strong)NSMutableArray * songList;
@property(nonatomic,strong)NSMutableArray * songPaths ;


LMSingletonH(LMMusic);


/**
 获取iTunes中的音乐
 */
-(void)startGetLocalMusic:(void (^)(NSArray * data ,NSArray * songPath))callback authorizedCb:(void(^)(BOOL authorized))authorizedCb;

/**
 停止获取音乐
 */
-(void)stopGetLocalMusic;

@end
