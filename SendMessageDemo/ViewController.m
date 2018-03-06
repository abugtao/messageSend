//
//  ViewController.m
//  SendMessageDemo
//
//  Created by zht on 2018/2/28.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "UIViewController+UserAction.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p = [[Person alloc] init];
    [p run:@"10"];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


- (void)nextAction:(UIButton *)btn{
//    self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
