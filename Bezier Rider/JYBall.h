//
//  JYBall.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/14/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "JYUtils.h"

@interface JYBall : SKShapeNode

- (instancetype)initWithColor:(UIColor *)color position:(CGPoint)position size:(CGSize)size;

@end
