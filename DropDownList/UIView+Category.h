//
//  UIView+Category.h
//  Cherry
//
//  Created by 杨 on 15/9/24.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
/**
 *  通过子view，获取所在viewController
 */
- (UIViewController *)findViewController;

/**
 *  通过子view(例如cell),获取tableView
 */
- (UITableView *)findTableView;

@end
