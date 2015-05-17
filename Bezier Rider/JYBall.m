//
//  JYBall.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/14/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYBall.h"

@implementation JYBall

- (instancetype)initWithColor:(UIColor *)color position:(CGPoint)position size:(CGSize)size {
    
    if (self = [super init]) {
        
        self.path = CGPathCreateWithEllipseInRect(CGRectMake(position.x - size.width / 2, position.y - size.height / 2, size.width, size.height), nil);
        
        self.fillColor = color;
        self.strokeColor = color;
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:size.width/2 center:position];
        self.physicsBody.affectedByGravity = NO;
        
        self.physicsBody.categoryBitMask = ballCategory;
        self.physicsBody.contactTestBitMask = wallCategory | curveCategory | targetCategory;
        self.physicsBody.collisionBitMask = wallCategory | curveCategory;
    }
    
    return self;
}

@end
