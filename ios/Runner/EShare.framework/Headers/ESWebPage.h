//
//  ESWebPage.h
//  EShare
//
//  Created by EShare on 2017/5/25.
//  Copyright © 2017年 Eshare. All rights reserved.

// 文件随心传中的网页界面

#import <Foundation/Foundation.h>
#import "LMSingleton.h"

@interface ESWebPage : NSObject

LMSingletonH(ESWebPage)

@property(nonatomic,copy)NSString * netTitle ;

@property(nonatomic,copy)NSString * companyTitle ;


/**
 设置网页标题

 @param netTitle 网页标题
 */
-(void)setNetTitle:(NSString *)netTitle;


/**
 设置网页中的公司名称

 @param companyTitle 网页中的公司名称
 */
-(void)setCompanyTitle:(NSString *)companyTitle;


@end
