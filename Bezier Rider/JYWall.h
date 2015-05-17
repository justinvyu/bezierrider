//
//  JYWall.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/17/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JYWall : SKShapeNode

- (instancetype)initWithPoint:(CGPoint)point andEndpoint:(CGPoint)endpoint;

@end
