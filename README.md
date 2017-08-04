# AnimationGroup
  一个简单的核心组动画,仅供参考!<br />
  [简书地址](http://www.jianshu.com/p/e8f314d8997b)<br />  
## Main
* LCItemView    盛放按钮和动画的视图
* LCSubItem     按钮
* UIImage+Draw  画图部分

## <a id="Details"></a>Details (See the example program AnimationGroup for details)
```objc
///单个展开动画
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
```

```objc
///单个关闭动画
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
```

```objc
///单个放大动画
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
```

```objc
///单个缩小动画
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
```
