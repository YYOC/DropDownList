//
//  ViewController.m
//  DropDownList
//
//  Created by 杨 on 15/11/12.
//  Copyright (c) 2015年 杨. All rights reserved.
//

#import "ViewController.h"
#import "HRPopoverView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 30, 250, 30);
    button.backgroundColor = [UIColor magentaColor];
    [button setTitle:@"咳咳咳咳咳咳咳咳咳咳咳咳" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    [HRPopoverView showPopoverView:sender array:@[@"123", @"熟练地将开放了司空见惯", @"涉及到快放假", @"我诶伛", @"拉斯克奖的分开始就熟练地将分离式的减肥上来看积分塑料袋发送"] didSelected:^(NSInteger index, id object) {
        NSLog(@"%@",object);
    }];
}

@end
