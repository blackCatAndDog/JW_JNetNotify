# JW_JNetNotify
处理多条通知，依次展示
_notifyView=[[JNetNotifyView alloc]initWithJNetNotifyViewSubStyle:JNetNotifyViewSubStyleDefault autoAnimation:NO];
[self.view addSubview:_notifyView];

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
for (int i=0; i<5; i++) {
[_notifyView addNextMessage:[JNetNotifyMessage messageWithTitle:@"通知" contents:[NSString stringWithFormat:@"%d次",count] time:@"12:58" imageUrl:nil]];
count++;
}
}
