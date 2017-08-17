//
//  ViewController.m
//  ZYQRouterDemo
//
//  Created by Zhao Yiqi on 2017/1/12.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"
#import "ZYQRouter.h"

@interface TmpView : UIView

@end

@implementation TmpView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        UIButton *btn=[[UIButton alloc] initWithFrame:self.bounds];
        [btn setTitle:@"主程序" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:30];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)btnClick{
    [[self nextResponder] zyq_routerEventWithName:@"MyTap" userInfo:nil];
}

@end

@interface TmpView1 : UIView

@end
@implementation TmpView1

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        TmpView *view=[[TmpView alloc] initWithFrame:frame];
        [self addSubview:view];
    }
    return self;
}

@end

@interface TmpView2 : UIView

@end

@implementation TmpView2

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        TmpView1 *view=[[TmpView1 alloc] initWithFrame:frame];
        [self addSubview:view];
    }
    return self;
}

@end

@interface TmpView3 : UIView

@end

@implementation TmpView3

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        TmpView2 *view=[[TmpView2 alloc] initWithFrame:frame];
        [self addSubview:view];
    }
    return self;
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TmpView3 *btn=[[TmpView3 alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)zyq_routerEventWithName:(NSString *)eventName userInfo:(id)userInfo{
    if ([eventName isEqualToString:@"MyTap"]) {
        NSLog(@"点击了");
        
        [ZYQRouter openURL:@"module1://view?log=我是主程序"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
