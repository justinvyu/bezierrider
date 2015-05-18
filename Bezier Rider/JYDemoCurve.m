//
//  JYDemoCurve.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/17/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYDemoCurve.h"

#import "JYUtils.h"
#import <FlatUIKit/FlatUIKit.h>

@implementation JYDemoCurve

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGPoint p0 = CGPointMake(5, 5);
    CGPoint p1 = CGPointMake(5 + WIDTH(self) / 3, HEIGHT(self) - 5);
    CGPoint p2 = CGPointMake(2 * WIDTH(self) / 3 - 5, HEIGHT(self) - 5);
    CGPoint p3 = CGPointMake(WIDTH(self) - 5, 5);
    
    UIBezierPath *sample = [UIBezierPath bezierPath];
    [sample moveToPoint:p0];
    [sample addCurveToPoint:p3 controlPoint1:p1 controlPoint2:p2];
    sample.lineWidth = 3.0f;
    [[UIColor cloudsColor] setStroke];
    [sample stroke];
    
    UIBezierPath *seg0 = [UIBezierPath bezierPath];
    [seg0 moveToPoint:p0];
    [seg0 addLineToPoint:p1];
    UIBezierPath *seg1 = [UIBezierPath bezierPath];
    [seg1 moveToPoint:p1];
    [seg1 addLineToPoint:p2];
    UIBezierPath *seg2 = [UIBezierPath bezierPath];
    [seg2 moveToPoint:p2];
    [seg2 addLineToPoint:p3];

    
    [[UIColor silverColor] setStroke];
    [seg0 stroke];
    [seg1 stroke];
    [seg2 stroke];
    
    UIBezierPath *point0 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(p0.x - 4, p0.y - 4, 8, 8)];
    UIBezierPath *point1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(p1.x - 4, p1.y - 4, 8, 8)];
    UIBezierPath *point2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(p2.x - 4, p2.y - 4, 8, 8)];
    UIBezierPath *point3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(p3.x - 4, p3.y - 4, 8, 8)];
    
    [[UIColor concreteColor] setFill];
    [point0 fill];
    [point1 fill];
    [point2 fill];
    [point3 fill];
}

@end
