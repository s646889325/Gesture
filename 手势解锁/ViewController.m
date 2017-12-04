//
//  ViewController.m
//  手势解锁
//
//  Created by qyhc on 17/8/17.
//  Copyright © 2017年 com.qykj. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.pch"
#import "LockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((KSCREENW - 100) / 2, 100, 100 , 100)];
    [btn setTitle:@"手势解锁" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}


- (void)btnClick{
    
    [self presentViewController:[[LockViewController alloc]init] animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
