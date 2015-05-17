//
//  JYPoint.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JYPoint : SKShapeNode

- (instancetype)initWithSize:(CGSize)size atPosition:(CGPoint)position color:(UIColor *)color;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@end
