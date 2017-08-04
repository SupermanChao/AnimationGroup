//
//  UIImage+Draw.h
//  Animation-ItemDemo
//
//  Created by 刘超 on 2017/8/2.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDefines.h"

@interface UIImage (Draw)

+ (UIImage *)imageWithShape:(LCImageShape)shap andSize:(CGSize)size andStrokeColor:(UIColor *)strokeColor;

@end
