//
//  UILabel+Addition.m
//  Cherry
//
//  Created by Frank Chen on 15-5-18.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

- (float)getLabelHeight
{
    CGSize size = CGSizeMake(CGRectGetWidth(self.bounds), 0);
    
    CGRect labelsize = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName] context:nil];
    
    return labelsize.size.height;
}

- (float)getLabelWidth
{
    CGSize size = CGSizeMake(0, CGRectGetHeight(self.bounds));
    
    CGRect labelsize = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName] context:nil];
    
    return labelsize.size.width;
}

@end
