//
//  UIImage+HR.m
//  Cherry
//
//  Created by 杨 on 15/9/24.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import "UIImage+HR.h"

@implementation UIImage (HR)

+(UIImage *)stretchedImageWithName:(NSString *)name{
    
    UIImage *image = [UIImage imageNamed:name];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

+ (UIImage *)captureView:(UIView *)theView {
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, TRUE, [[UIScreen mainScreen] scale]);
//    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
