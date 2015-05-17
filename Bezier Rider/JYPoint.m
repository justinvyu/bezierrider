//
//  JYPoint.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYPoint.h"

@implementation JYPoint

- (instancetype)initWithSize:(CGSize)size atPosition:(CGPoint)position color:(UIColor *)color {
    
    if (self = [super init]) {
        
        self.x = position.x;
        self.y = position.y;
        
        CGRect boundingBox = CGRectMake(position.x - size.width / 2, position.y - size.height / 2, size.width, size.height);
        CGPathRef path = CGPathCreateWithEllipseInRect(boundingBox, nil);
        self.path = path;
        self.fillColor = color;
        self.strokeColor = color;
    }
    
    return self;
}

@end
