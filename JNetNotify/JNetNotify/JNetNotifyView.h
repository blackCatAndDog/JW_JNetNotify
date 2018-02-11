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
    JNetNotifyViewSubStyleCustom,
};


@interface JNetNotifyView : UIView
/*
    isAutoAnimation == yes 自动显示   isAutoAnimation == no 手势控制下一条消息显示
    @仅支持JNetNotifyViewSubStyleDefault
 */

-(instancetype)initWithJNetNotifyViewSubStyle:(JNetNotifyViewSubStyle)style autoAnimation:(BOOL)isAutoAnimation;

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
