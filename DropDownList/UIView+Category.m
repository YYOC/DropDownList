//
//  UIView+Category.m
//  Cherry
//
//  Created by 杨 on 15/9/24.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (UIViewController *)findViewController
{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (UITableView *)findTableView {
    id target = self;
    while (target) {
        target = ((UIView *)target).superview;
        if ([target isKindOfClass:[UITableView class]]) {
            break;
        }
    }
    return target;
}

@end
