//
//  JYWall.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/17/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYWall.h"

#import "JYUtils.h"

@implementation JYWall

- (instancetype)initWithPoint:(CGPoint)point andEndpoint:(CGPoint)endpoint {
    
    if (self = [super init]) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, point.x, point.y);
        CGPathAddLineToPoint(path, NULL, endpoint.x, endpoint.y);
        
        self.path = path;
        
        self.lineWidth = 5.0f;
        self.strokeColor = [UIColor blackColor];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        self.physicsBody.categoryBitMask = wallCategory;
    }
    
    return self;
}

@end
