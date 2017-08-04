//
//  LCItemView.m
//  Animation-ItemDemo
//
//  Created by 刘超 on 2017/8/2.
//  Copyright © 2017年 ogemray. All rights reserved.
//

#import "LCItemView.h"

@interface LCItemView ()<LCSubItemDelegate>

@property (nonatomic, strong) LCSubItem *mainItem;
@property (nonatomic, strong) NSMutableArray<LCSubItem *> *subItems;
@property (nonatomic, assign) CGPoint starPoint;
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) BOOL isExpanding;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger flag;

@end

@implementation LCItemView

- (instancetype)initWithFrame:(CGRect)frame andMainImage:(UIImage *)mainImage andSubItems:(NSArray *)subImages
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.starPoint = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        self.radius = 150.0;
        
        [self initSubItemsWithImgs:subImages];
        [self setupMainItemWithImage:mainImage];
    }
    return self;
}

///布局自按钮的位置
- (void)initSubItemsWithImgs:(NSArray *)imgs
{
    [self.subItems removeAllObjects];
    
    if (!imgs || imgs.count == 0) {
        return;
    }
    
    for (int i = 0; i < imgs.count; i++) {
        
        LCSubItem *item = [[LCSubItem alloc] initWithImage:[imgs objectAtIndex:i]];
        
        item.starPoint = self.starPoint;
        item.endPoint = CGPointMake(self.starPoint.x + self.radius * cosf(2*M_PI / imgs.count * i), self.starPoint.y + self.radius * sinf(2*M_PI / imgs.count * i));
        item.nearPoint = CGPointMake(item.starPoint.x + (self.radius - 40) * cosf(2*M_PI / imgs.count * i), self.starPoint.y + (self.radius - 40) * sinf(2*M_PI / imgs.count * i));
        item.farPoint = CGPointMake(item.starPoint.x + (self.radius + 50) * cosf(2*M_PI / imgs.count * i), self.starPoint.y + (self.radius + 50) * sinf(2*M_PI / imgs.count * i));
        item.center = item.starPoint;
        
        item.tag = 100 + i;
        item.delegate = self;
        [self addSubview:item];
        
        [self.subItems addObject:item];
    }
}

///初始化主键相关
- (void)setupMainItemWithImage:(UIImage *)image
{
    self.mainItem = [[LCSubItem alloc] initWithImage:image];
    self.mainItem.center = self.starPoint;
    self.mainItem.delegate = self;
    [self addSubview:self.mainItem];
}

- (void)itemTouchesEnd:(LCSubItem *)item
{
    if (item == self.mainItem) {
        self.isExpanding = !self.isExpanding;
    }else {
        //点击了子按钮
        [self.subItems enumerateObjectsUsingBlock:^(LCSubItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj == item) {
                [obj.layer addAnimation:[self blowupAnimation:obj.endPoint] forKey:@"beowupAnimation"];
                
                if ([self.delegate respondsToSelector:@selector(clickSubItemWithIndex:)]) {
                    [self.delegate clickSubItemWithIndex:obj.tag - 100];
                }
                
            }else {
                [obj.layer addAnimation:[self shrinkAnimation:obj.endPoint] forKey:@"shrinkAnimation"];
            }
            
            obj.center = obj.starPoint;
            
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.mainItem.transform = CGAffineTransformMakeRotation(0);
        }];
        _isExpanding = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isExpanding) {
        self.isExpanding = NO;
    }
}

- (void)setIsExpanding:(BOOL)isExpanding
{
    if (_isExpanding == isExpanding) {
        return;
    }
    _isExpanding = isExpanding;
    
    float angle = _isExpanding ? M_PI_4 : 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.mainItem.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    self.flag = _isExpanding ? 0 : self.subItems.count - 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025
                                                  target:self
                                                selector:_isExpanding ? @selector(expand) : @selector(close)
                                                userInfo:nil
                                                 repeats:YES];
    [self.timer setFireDate:[NSDate distantPast]];
}

- (void)expand
{
    if (self.flag == self.subItems.count - 1) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
    
    LCSubItem *item = [self.subItems objectAtIndex:self.flag];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:item.starPoint];
    [path addLineToPoint:item.farPoint];
    [path addLineToPoint:item.nearPoint];
    [path addLineToPoint:item.endPoint];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.6f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.path = path.CGPath;
    [item.layer addAnimation:animation forKey:@"Expand"];
    
    item.center = item.endPoint;
    
    self.flag ++;
    
}

- (void)close
{
    if (self.flag == 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    LCSubItem *item = [self.subItems objectAtIndex:self.flag];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:item.endPoint];
    [path addLineToPoint:item.farPoint];
    [path addLineToPoint:item.starPoint];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.path = path.CGPath;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.toValue = @(M_PI * 2);
    animation2.duration = 0.3;
    animation2.repeatDuration = animation.duration + 0.3;
    animation2.repeatCount = animation2.repeatDuration / animation2.duration;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation,animation2, nil];
    group.duration = animation.duration;
    [item.layer addAnimation:group forKey:@"Close"];
    
    item.center = item.starPoint;
    self.flag --;
}

///放大动画
- (CAAnimationGroup *)blowupAnimation:(CGPoint)point
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:point];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.duration = 0.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.toValue = @3;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.toValue = @0;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation,animation1,animation2, nil];
    group.duration = 0.5;
    
    return group;
}

///缩小动画
- (CAAnimationGroup *)shrinkAnimation:(CGPoint)point
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:point];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.duration = 0.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.toValue = @0.1;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.toValue = @0;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation,animation1,animation2, nil];
    group.duration = 0.5;
    
    return group;
}


- (NSMutableArray *)subItems
{
    if (!_subItems) {
        _subItems = [NSMutableArray array];
    }
    return _subItems;
}

@end
