//
//  UIImage+HR.h
//  Cherry
//
//  Created by 杨 on 15/9/24.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HR)

/**
 *返回中心拉伸的图片
 */
+(UIImage *)stretchedImageWithName:(NSString *)name;

/**
 *  将view截成图片
 */
+ (UIImage *)captureView:(UIView *)theView;

@end
