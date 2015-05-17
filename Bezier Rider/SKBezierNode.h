//
//  SKBezierNode.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/15/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKBezierNode : SKShapeNode

- (instancetype)initWithPoints:(NSArray *)points color:(UIColor *)color;

@end
