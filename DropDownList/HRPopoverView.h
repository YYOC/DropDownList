//
//  HRPopoverView.h
//  Cherry
//
//  Created by 杨 on 15/9/24.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRPopoverView : UIView

+ (void)showPopoverView:(UIView *)view array:(NSArray *)array didSelected:(void (^) (NSInteger index,id object))block;

@end



@interface HRPopoverViewCell : UITableViewCell

@property (nonatomic, strong) NSString *title;

- (id)initWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)cellHeightWithText:(NSString *)text width:(CGFloat)width;

@end