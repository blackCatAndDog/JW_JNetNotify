//
//  ViewController.m
//  JNetNotify
//
//  Created by Wei Zou on 2018/2/11.
//  Copyright © 2018年 Wei Zou. All rights reserved.
//

#import "ViewController.h"
#import "JNetNotifyView.h"
static int count = 0;
@interface ViewController (){
    JNetNotifyView *_notifyView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    _notifyView=[[JNetNotifyView alloc]initWithJNetNotifyViewSubStyle:JNetNotifyViewSubStyleDefault];
    [self.view addSubview:_notifyView];
    

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i=0; i<5; i++) {
        [_notifyView addNextMessage:[JNetNotifyMessage messageWithTitle:@"通知" contents:[NSString stringWithFormat:@"%d次",count] time:@"12:58" imageUrl:nil]];
        count++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
