//
//  TouchRecord.h
//  EmouseRemote
//
//  Created by xiangbin luo on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TouchRecord : NSObject

 // 用以唯一标识touch对象，实际他是传入的touches集合中touch对象的指针
@property(nonatomic,strong)id m_id;
// touch对象的位置
@property(nonatomic,assign) CGPoint m_point;
//touch对象的状态
@property(nonatomic,assign)  UITouchPhase m_phase;

- (instancetype)initWithTouch:(UITouch*)aTouch pointInView:(CGPoint)point;

@end
