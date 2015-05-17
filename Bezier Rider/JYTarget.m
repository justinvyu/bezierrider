//
//  JYTarget.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/16/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYTarget.h"

#import "JYUtils.h"

@implementation JYTarget

- (instancetype)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size {
    
    if (self = [super initWithTexture:texture color:color size:size]) {
        
        self.physicsBody = [SKPhysicsBody bodyWithTexture:texture size:size];
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = targetCategory;
        self.physicsBody.contactTestBitMask = ballCategory;
    }
    return self;
}

@end
