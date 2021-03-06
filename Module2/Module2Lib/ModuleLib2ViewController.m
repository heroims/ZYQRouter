//
//  ModuleLib2ViewController.m
//  Module2
//
//  Created by Zhao Yiqi on 2017/1/12.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ModuleLib2ViewController.h"
#import "ZYQRouter.h"
@interface ModuleLib2ViewController ()

@property(nonatomic,strong)UIViewController *myVC;

@end

@implementation ModuleLib2ViewController

-(void)dealloc{
    NSLog(@"delloc ModuleLib2ViewController!!!");
}

+(ModuleLib2ViewController*)pushController:(UIViewController*)parentVC log:(NSString*)log{
    NSLog(@"%@",log);
    ModuleLib2ViewController *vc=[[ModuleLib2ViewController alloc] init];
    [parentVC.navigationController pushViewController:vc animated:YES];
    return vc;
}

+(NSString*)printClass:(UIViewController*)vc log:(NSString*)log{
    return [NSString stringWithFormat:@"传来的对象Class:%@  \nlog:%@",[vc class],log];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc] initWithFrame:self.view.bounds];
    [btn setTitle:@"Module2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:btn];

    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

-(void)btnClick{
    NSLog(@"点击了");
    [ZYQRouter openURL:@"module1://view?log=我是Module2" completion:^(id result) {
        [(UIViewController*)result setTitle:@"form Module2"];
    }];
/*  静态方法对象持久处理处理不好会提前释放如下面代码 
    self.myVC=[ZYQRouter performTarget:@"ModuleLib1ViewController" action:@"pushController:log:" objects:self,@"我是Module2",nil];
    self.myVC.title=@"form Module2";
*/
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
