//
//  LCDefines.h
//  Animation-ItemDemo
//
//  Created by 刘超 on 2017/8/2.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LCImageShape) {
    LCImageShapeMainItem,
    LCImageShapeSubItem
};


/**
 *  基于当前屏幕的倍数,对传进来的 floatValue 进行像素取整
 *  2x倍数下 1pt = 2px 3x倍数下 1pt = 3px
 *  例如:传进来 "2.4",在 2x 倍数下会返回 2.5 在3x下会返回 3.66666...
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/// 将一个CGSize像素对齐
CG_INLINE CGSize
CGSizeFlatted(CGSize size) {
    return CGSizeMake(flat(size.width), flat(size.height));
}
