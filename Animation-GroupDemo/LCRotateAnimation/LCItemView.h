//
//  代码地址:https://github.com/SupermanChao/CATransaction-Demo
//  简书地址:http://www.jianshu.com/u/d6fe286d5fad
//
//  Created by 刘超 on 2017/8/2.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSubItem.h"
#import "UIImage+Draw.h"

@protocol LCItemViewDelegate <NSObject>

- (void)clickSubItemWithIndex:(NSUInteger)index;

@end

@interface LCItemView : UIView

@property (nonatomic, assign) id<LCItemViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andMainImage:(UIImage *)mainImage andSubItems:(NSArray *)subImages;

@end
