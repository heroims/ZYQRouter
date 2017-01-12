//
//  ViewController.m
//  ZYQRouterDemo
//
//  Created by Zhao Yiqi on 2017/1/12.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"
#import "ZYQRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:self.view.bounds];
    [btn setTitle:@"主程序" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)btnClick{
    NSLog(@"点击了");
    
    [ZYQRouter openURL:@"module1://view?log=我是主程序"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
