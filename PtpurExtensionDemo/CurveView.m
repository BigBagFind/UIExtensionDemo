
//
//  CurveView.m
//  BezierAndAnimation
//
//  Created by 吴玉铁 on 2017/1/4.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

#import "CurveView.h"


@interface CurveView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CurveView





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //UIColor *color = [UIColor redColor];
    //[color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    //aPath.lineWidth = 10.0;
    
   // aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    //aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(0, 0)];
    
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(100.0, 40.0)];
    [aPath addLineToPoint:CGPointMake(160, 140)];
    [aPath addLineToPoint:CGPointMake(220.0, 140)];
    [aPath addLineToPoint:CGPointMake(320.0, 160.0)];
    [aPath addLineToPoint:CGPointMake(350.0, 200.0)];
    [aPath addLineToPoint:CGPointMake(320.0, 200.0)];
    [aPath addLineToPoint:CGPointMake(330.0, 300.0)];
    [aPath addLineToPoint:CGPointMake(340.0, 400.0)];
    [aPath addLineToPoint:CGPointMake(280.0, 420.0)];
   // [aPath closePath];//第五条线通过调用closePath方法得到的
//    [aPath stroke];
    
    //初始化shapeLayer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.lineWidth = 5;
    _shapeLayer.strokeColor = [UIColor greenColor].CGColor;//边沿线色
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
  //  _shapeLayer.fillColor = [UIColor grayColor].CGColor;//填充色
    
    _shapeLayer.lineJoin = kCALineCapRound;//线拐点的类型
    _shapeLayer.lineCap = kCALineCapRound;//线终点

    //从贝塞尔曲线获得形状
    _shapeLayer.path = aPath.CGPath;
    
    //起始和终止
    _shapeLayer.strokeStart = 0.0;
    _shapeLayer.strokeEnd = 1.0;

    
    //将layer添加进图层
    [self.layer addSublayer:_shapeLayer];
    [self startAnimation];
  
    
}


- (void)startAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
   // animation
    animation.fromValue = @0;
    
    animation.toValue = @1;
    
    animation.repeatCount = 1;
    
    animation.duration = 2.0f;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    [_shapeLayer addAnimation:animation forKey:nil];

}


@end
