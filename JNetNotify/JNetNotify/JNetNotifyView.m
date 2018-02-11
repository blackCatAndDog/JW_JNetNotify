//
//  JNetNotifyView.m
//  JWPosition
//
//  Created by Wei Zou on 2018/1/22.
//  Copyright © 2018年 Wei Zou. All rights reserved.
//

#import "JNetNotifyView.h"
#define NotifyHeight 70.0f
#define NotifyWIDTH [UIScreen mainScreen].bounds.size.width
static BOOL isAnimation = NO;
@interface JNetNotifyView(){
    dispatch_queue_t _asyncQueue;
}

@property(nonatomic,strong,readwrite)NSMutableArray <JNetNotifyMessage *>*messageQueue;

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UILabel     *titleLabel;

@property(nonatomic,strong)UILabel     *contentLabel;

@property(nonatomic,strong)UILabel     *timeLabel;

-(void)defaultBuild;
-(void)handleNextMessage:(JNetNotifyMessage *)nextMessage;

@end

@implementation JNetNotifyView

-(instancetype)init
{
    return [self initWithJNetNotifyViewSubStyle:JNetNotifyViewSubStyleDefault];
}

-(instancetype)initWithJNetNotifyViewSubStyle:(JNetNotifyViewSubStyle)style
{
    NSLog(@"%@",[NSThread currentThread]);
    self=[super initWithFrame:CGRectMake(0, -NotifyHeight, NotifyWIDTH, NotifyHeight)];
    if (self) {
        _messageQueue=[NSMutableArray array];
        self.backgroundColor=[UIColor whiteColor];
        _asyncQueue=dispatch_queue_create("jingwei", NULL);
        [self defaultBuild];
    }
    return self;
}

-(void)defaultBuild
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 30, 30)];
    imageView.layer.cornerRadius=5.0f;
    imageView.layer.masksToBounds=YES;
    [self addSubview:imageView];
    _imageView=imageView;
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, NotifyWIDTH-60, 17)];
    titleLabel.font=[UIFont systemFontOfSize:17];
    [self addSubview:titleLabel];
    _titleLabel=titleLabel;
    UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 50, NotifyWIDTH-60-30, 13)];
    contentLabel.font=[UIFont systemFontOfSize:13];
    contentLabel.textColor=[UIColor grayColor];
    [self addSubview:contentLabel];
    _contentLabel=contentLabel;
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(NotifyWIDTH-100, 48, 100, 13)];
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:timeLabel];
    _timeLabel=timeLabel;
    
}

-(void)addNextMessage:(JNetNotifyMessage *)message
{
    @synchronized (_messageQueue){
        [_messageQueue insertObject:message atIndex:0];
    }
    if (!isAnimation) {
        isAnimation=YES;
        [self handleNextMessage:_messageQueue.lastObject];
    }
    
}

-(void)handleNextMessage:(JNetNotifyMessage *)nextMessage
{
    //后面改为异步
    
    dispatch_async(_asyncQueue, ^{
        NSData *tmp=[NSData dataWithContentsOfURL:[NSURL URLWithString:nextMessage.imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image=[UIImage imageWithData:tmp];
            self.imageView.image=[UIImage imageNamed:@"timg.jpeg"];
            self.titleLabel.text=nextMessage.title;
            self.contentLabel.text=nextMessage.contents;
            self.timeLabel.text=nextMessage.time;
            [UIView animateWithDuration:0.2f delay:0.1f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.frame=CGRectMake(0, 0, NotifyWIDTH, NotifyHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2f delay:3.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.frame=CGRectMake(NotifyWIDTH, 0, NotifyWIDTH, NotifyHeight);
                } completion:^(BOOL finished) {
                    self.frame=CGRectMake(0, -NotifyHeight, NotifyWIDTH, NotifyHeight);
                    [_messageQueue removeLastObject];
                    if (_messageQueue.count>0) {
                        [self handleNextMessage:_messageQueue.lastObject];
                    }
                    else
                        isAnimation=NO;
                }];
            }];
        });
        
    });
}

@end



@interface JNetNotifyMessage()

@property(nonatomic,copy,readwrite)NSString *title;
@property(nonatomic,copy,readwrite)NSString *contents;
@property(nonatomic,copy,readwrite)NSString *time;
@property(nonatomic,copy,readwrite)NSString *imageUrl;

@end

@implementation JNetNotifyMessage

+(instancetype)messageWithTitle:(NSString *)title contents:(NSString *)contents time:(NSString *)time imageUrl:(NSString *)url
{
     JNetNotifyMessage *notifyMessage=[[self alloc]init];
    notifyMessage.title=title;
    notifyMessage.contents=contents;
    notifyMessage.time=time;
    notifyMessage.imageUrl=url;
    return notifyMessage;
}


@end
