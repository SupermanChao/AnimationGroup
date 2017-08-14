//
//  代码地址:https://github.com/SupermanChao/CATransaction-Demo
//  简书地址:http://www.jianshu.com/u/d6fe286d5fad
//
//  Created by 刘超 on 2017/8/2.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import "UIImage+Draw.h"

@implementation UIImage (Draw)

+ (UIImage *)imageWithShape:(LCImageShape)shap andSize:(CGSize)size andStrokeColor:(UIColor *)strokeColor
{
    size = CGSizeFlatted(size);
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    UIBezierPath *path = nil;
    float lineWidth = shap == LCImageShapeMainItem ? 4:3;
    
    if (shap == LCImageShapeMainItem) {
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(lineWidth * 0.5, lineWidth * 0.5, size.width - lineWidth, size.height - lineWidth)];
        
        [path moveToPoint:CGPointMake(6, size.height * 0.5)];
        [path addLineToPoint:CGPointMake(size.width - 6, size.height * 0.5)];
        
        [path moveToPoint:CGPointMake(size.width * 0.5, 6)];
        [path addLineToPoint:CGPointMake(size.width * 0.5, size.height - 6)];
        
        path.lineWidth = lineWidth;
        
        [strokeColor setStroke];
        [path stroke];
    }else {
        
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(lineWidth * 0.5, lineWidth * 0.5, size.width - lineWidth, size.height - lineWidth)];
        
        path.lineWidth = lineWidth;
        [[UIColor blackColor] setStroke];
        [path stroke];
        
        
        float partWidth = (size.width * 0.5 - 6) / 4;
        float partHeight = (size.height * 0.5 - 6) / 4;
        
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        
        [path2 moveToPoint:CGPointMake(6, size.height * 0.5)];
        [path2 addLineToPoint:CGPointMake(partWidth * 3 + 6, partHeight * 3 + 6)];
        [path2 addLineToPoint:CGPointMake(size.width * 0.5, 6)];
        [path2 addLineToPoint:CGPointMake(partWidth * 5 + 6 , partHeight * 3 + 6)];
        [path2 addLineToPoint:CGPointMake(size.width - 6, size.height * 0.5)];
        [path2 addLineToPoint:CGPointMake(partWidth * 5 + 6, partHeight * 5 + 6)];
        [path2 addLineToPoint:CGPointMake(size.width * 0.5, size.height - 6)];
        [path2 addLineToPoint:CGPointMake(partWidth * 3 + 6, partHeight * 5 + 6)];
        [path2 closePath];
        path2.lineWidth = 0.1;
        [strokeColor setFill];
        [path2 fill];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
