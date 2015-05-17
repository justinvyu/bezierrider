//
//  SKBezierNode.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/15/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "SKBezierNode.h"

#import "JYPoint.h"
#import "JYUtils.h"

@implementation SKBezierNode

- (instancetype)initWithPoints:(NSArray *)points color:(UIColor *)color {
    
    if (self = [super init]) {
        
        self.lineWidth = 3.0f;
        self.lineCap = 1.0f;
        
        self.strokeColor = color;
        
        // Path
        
        CGMutablePathRef bezierCurve = CGPathCreateMutable();
        
        if ([points count] == 3) {
            // Quadratic - 3 control points
            
            JYPoint *p0 = (JYPoint *)points[0];
            JYPoint *p1 = (JYPoint *)points[1];
            JYPoint *p2 = (JYPoint *)points[2];

            CGPathMoveToPoint(bezierCurve, NULL, p0.x, p0.y);
            CGPathAddQuadCurveToPoint(bezierCurve, NULL, p1.x, p1.y, p2.x, p2.y);
            
        } else if ([points count] == 4) {
            // Cubic - 4 control points
            
            JYPoint *p0 = (JYPoint *)points[0];
            JYPoint *p1 = (JYPoint *)points[1];
            JYPoint *p2 = (JYPoint *)points[2];
            JYPoint *p3 = (JYPoint *)points[3];
            
            CGPathMoveToPoint(bezierCurve, NULL, p0.x, p0.y);
            CGPathAddCurveToPoint(bezierCurve, NULL, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
            
        }
        
        self.path = bezierCurve;
        
        // Physics Body
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:bezierCurve];
        
        self.physicsBody.categoryBitMask = curveCategory;
        self.physicsBody.contactTestBitMask = ballCategory;
        self.physicsBody.collisionBitMask = ballCategory;
        
        self.physicsBody.dynamic = NO;
        
    }
    
    return self;
}

@end
