//
//  ViewController.m
//  CDButton
//
//  Created by George on 2016/12/14.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "ViewController.h"
#import "CDButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CDButton *button = [CDButton button];
    button.frame =CGRectMake(100, 100, 100, 30);
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
