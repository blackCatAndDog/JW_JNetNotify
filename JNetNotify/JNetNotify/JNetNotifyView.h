//
//  JNetNotifyView.h
//  JWPosition
//
//  Created by Wei Zou on 2018/1/22.
//  Copyright © 2018年 Wei Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JNetNotifyMessage;
typedef NS_ENUM(NSInteger, JNetNotifyViewSubStyle) {
    JNetNotifyViewSubStyleDefault,
};
@interface JNetNotifyView : UIView

-(instancetype)initWithJNetNotifyViewSubStyle:(JNetNotifyViewSubStyle)style;

-(void)addNextMessage:(JNetNotifyMessage *)message;

@end

@interface JNetNotifyMessage : NSObject

@property(nonatomic,copy,readonly)NSString *title;

@property(nonatomic,copy,readonly)NSString *contents;

@property(nonatomic,copy,readonly)NSString *time;

@property(nonatomic,copy,readonly)NSString *imageUrl;

+(instancetype)messageWithTitle:(NSString *)title
                       contents:(NSString *)contents
                           time:(NSString *)time
                       imageUrl:(NSString *)url;

@end
