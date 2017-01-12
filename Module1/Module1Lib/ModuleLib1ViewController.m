//
//  ModuleLibViewController.m
//  Module1
//
//  Created by Zhao Yiqi on 2017/1/12.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ModuleLib1ViewController.h"
#import "ZYQRouter.h"
@interface ModuleLib1ViewController ()

@end

@implementation ModuleLib1ViewController
-(void)dealloc{
    NSLog(@"delloc ModuleLib1ViewController!!!");
}

+(void)load{
    [ZYQRouter registerURLPattern:@"module1://view" toObjectHandler:^id(NSDictionary *routerParameters) {
        ModuleLib1ViewController *vc=[[ModuleLib1ViewController alloc] init];
        NSLog(@"module1log:%@",routerParameters[@"log"]);
        [(UINavigationController*)[[UIApplication sharedApplication].keyWindow rootViewController] pushViewController:vc animated:YES];
        return vc;
    }];
}

- (ModuleLib1ViewController*)pushController:(UIViewController*)parentVC log:(NSString*)log{
    NSLog(@"%@",log);
    [parentVC.navigationController pushViewController:self animated:YES];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc] initWithFrame:self.view.bounds];
    [btn setTitle:@"Module1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

-(void)btnClick{
    NSLog(@"点击了");
   
    UIViewController *myVC= (__bridge id)invokeSelectorObjects(@"ModuleLib2ViewController", @"pushController:log:",self,@"我是Module1",nil);
    myVC.title=@"from Module1";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
