//
//  LCSubItem.h
//  Animation-ItemDemo
//
//  Created by 刘超 on 2017/8/2.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCSubItem;

@protocol LCSubItemDelegate <NSObject>

- (void)itemTouchesEnd:(LCSubItem *)item;

@end

@interface LCSubItem : UIImageView

/// 起点
@property (nonatomic,assign) CGPoint starPoint;

/// 终点
@property (nonatomic,assign) CGPoint endPoint;

/// 近日点
@property (nonatomic,assign) CGPoint nearPoint;

/// 远日点
@property (nonatomic,assign) CGPoint farPoint;

@property (nonatomic, assign) id<LCSubItemDelegate> delegate;

@end
