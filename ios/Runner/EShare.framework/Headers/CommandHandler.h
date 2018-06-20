//
//  CommandHandler.h
//  ERemote
//
//  Created by xiangbin luo on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TouchRecord.h"
@class Global  ;
@interface CommandHandler : NSObject
{
    float mScaleFactorX;
    float mScaleFactorY;       
}

/**
 设置手机端与TV端的屏幕比例

 @param scaleX 宽度比例
 @param scaleY 高度比例
 @param view 手机端与tv端要对应的界面

 */
- (void)setScaleFactor:(float)scaleX scaleY:(float)scaleY view:(UIView *)view;

- (void)sendSwitchMsg:(NSInteger)on_off;



@end
