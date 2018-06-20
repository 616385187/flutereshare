//
//  UIImage+fixOrientation.h
//  EShareCVT
//
//  Created by EShare on 15/10/9.
//  Copyright © 2015年 XuMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;


- (UIImage *)imageScaleAspectToMaxSize:(CGFloat)newSize;

- (UIImage *)imageScaleAndCropToMaxSize:(CGSize)newSize;

@end
