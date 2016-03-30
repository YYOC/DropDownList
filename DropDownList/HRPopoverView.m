//
//  HRPopoverView.m
//  Cherry
//
//  Created by 杨 on 15/9/24.
//  Copyright (c) 2015年 conquer. All rights reserved.
//

#import "HRPopoverView.h"
#import "UILabel+Addition.h"
#import "UIImage+HR.h"
#import "UIView+Category.h"

typedef void(^DidSelectedBlock)(NSInteger index,id object);

static const float fontFloat = 16.f;

@interface HRPopoverView () <UITableViewDataSource, UITableViewDelegate>
{
    void (^_didDismissView)(void);
    DidSelectedBlock _didSeleted;
    UITapGestureRecognizer *_tap;
    UITableView *_tableView;
    
    NSArray *_dataSource;
}
@end

@implementation HRPopoverView

+ (void)showPopoverView:(UIView *)view array:(NSArray *)array didSelected:(DidSelectedBlock)block {
    __block HRPopoverView *popoverView = [[HRPopoverView alloc] initWithView:view array:array didSelected:block didDismissView:^{
        [popoverView removeFromSuperview];
        popoverView = nil;
    }];
    [popoverView show];
}

#pragma mark - life cycle
- (instancetype)initWithView:(UIView *)view array:(NSArray *)array didSelected:(DidSelectedBlock)didSeleted didDismissView:(void (^)(void))didDismissView {
    self = [super init];
    if (self) {
        _didDismissView = didDismissView;
        _didSeleted = didSeleted;
        _dataSource = [[NSArray alloc] initWithArray:array];
        [self initUIWithView:view];
    }
    return self;
}

- (void)dealloc {
    [self removeGestureRecognizer:_tap];
    _didDismissView = nil;
    _didSeleted = nil;
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
    _dataSource = nil;
}

#pragma mark - UITableView dataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [_dataSource objectAtIndex:indexPath.row];
    return [HRPopoverViewCell cellHeightWithText:string width:CGRectGetWidth(tableView.bounds)]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifire = @"HRPopoverViewCell";
    HRPopoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifire];
    if (!cell) {
        cell = [[HRPopoverViewCell alloc] initWithTableView:tableView style:UITableViewCellStyleDefault reuseIdentifier:Identifire];
    }
    
    NSString *string = [_dataSource objectAtIndex:indexPath.row];
    cell.title = string;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_didSeleted) {
        NSInteger index = indexPath.row;
        _didSeleted(index,[_dataSource objectAtIndex:index]);
    }
    [self hidden];
}

#pragma mark - UI
- (void)initUIWithView:(UIView *)view {
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:.3f];
    
    UIViewController *viewController = [view findViewController];
    self.frame = viewController.view.bounds;
    [viewController.view addSubview:self];
//    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
//    self.frame = window.bounds;
//    [window addSubview:self];
    
    UIView *tapView = [[UIView alloc] initWithFrame:self.bounds];
    tapView.backgroundColor = [UIColor clearColor];
    [self addSubview:tapView];
    
    [self addTap:tapView];
    
    CGRect rect = [view.superview convertRect:view.frame toView:viewController.view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage captureView:view];
    [self addSubview:imageView];
    
    [self addTableView:CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)+1, CGRectGetWidth(rect), 0)];
}

- (void)addTableView:(CGRect)frame {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        _tableView = tableView;
    }
    
    [self addSubview:_tableView];
}

#pragma mark - tap
- (void)addTap:(UIView *)tapView {
    tapView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissView)];
    [tapView addGestureRecognizer:tap];
    _tap = tap;
}

#pragma mark - action
- (void)dissmissView {
    [self hidden];
}

#pragma mark - show & hidden
- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _tableView.frame;
        rect.size.height = CGRectGetHeight(self.frame)-rect.origin.y-40;
        _tableView.frame = rect;
    }];
}

- (void)hidden {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _tableView.frame;
        rect.size.height = 0;
        _tableView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (_didDismissView) {
            _didDismissView();
        }
    }];
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    
    if (_tableView.contentSize.height < CGRectGetHeight(_tableView.frame) && _tableView.contentSize.height != 0) {
//        _tableView.scrollEnabled = NO;
        CGRect rect = _tableView.frame;
        rect.size.height = _tableView.contentSize.height;
        _tableView.frame = rect;
    }
    
    [super layoutSubviews];
}

@end



#pragma mark - =========================PopoverTableViewCell==================================


@interface HRPopoverViewCell ()
{
    UITableView *_tableView;
    UILabel *_titleLabel;
}
@end

@implementation HRPopoverViewCell

- (id)initWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _tableView = tableView;
        [self initUI];
    }
    return self;
}

- (void)dealloc {
    _titleLabel = nil;
}

#pragma mark - UI
- (void)initUI {
    
    [self.contentView addSubview:self.titleLabel];
    
    [self addBgImg];
}

- (void)addBgImg {
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage stretchedImageWithName:@"ic_preference_single_normal"]];
    self.backgroundView = bgImg;
    
    UIImageView *selectedBgImg = [[UIImageView alloc] initWithImage:[UIImage stretchedImageWithName:@"ic_preference_single_pressed"]];
    self.selectedBackgroundView = selectedBgImg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, CGRectGetWidth(_tableView.frame)-10, 20)];
        titleLable.numberOfLines = 0;
        titleLable.font = [UIFont systemFontOfSize:fontFloat];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [UIColor blackColor];
        _titleLabel = titleLable;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect titleRect = _titleLabel.frame;
    titleRect.size.height = [HRPopoverViewCell labelHeightWithText:self.titleLabel.text width:CGRectGetWidth(_tableView.frame)];
    _titleLabel.frame = titleRect;
    CGFloat height = [HRPopoverViewCell cellHeightWithText:self.titleLabel.text width:CGRectGetWidth(_tableView.frame)];
    CGRect backgroundRect = self.backgroundView.bounds;
    backgroundRect.size.height = height;
    self.backgroundView.bounds = backgroundRect;
    self.selectedBackgroundView.bounds = backgroundRect;
}

#pragma mark - cell height
+ (CGFloat)cellHeightWithText:(NSString *)text width:(CGFloat)width {
    
    CGFloat height = [HRPopoverViewCell labelHeightWithText:text width:width];
    
    return (height+20);
}

+ (CGFloat)labelHeightWithText:(NSString *)text width:(CGFloat)width {
    CGSize size = CGSizeMake(width-10, 0);
    
    CGFloat labelHeight = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontFloat] forKey:NSFontAttributeName] context:nil].size.height;
    
    CGFloat height = 20.f;
    if (labelHeight>height) {
        height = labelHeight;
    }
    
    return height;
}

@end