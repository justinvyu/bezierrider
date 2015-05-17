//
//  JYHighlightNode.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/16/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYHighlightNode.h"
#import <FlatUIKit/FlatUIKit.h>

@implementation JYHighlightNode

- (instancetype)initWithPosition:(CGPoint)position size:(CGSize)size {
    
    if (self = [super init]) {
        
        self.path = CGPathCreateWithEllipseInRect(CGRectMake(position.x - size.width / 2, position.y - size.height / 2, size.width, size.height), NULL);
        self.strokeColor = [UIColor alizarinColor];
        self.fillColor = [UIColor clearColor];
        self.lineWidth = 2.0f;
        
        self.name = @"highlight";
        [self flash];
    }
    
    return self;
}

- (void)flash {
    
    SKAction *flash = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.8f], [SKAction fadeInWithDuration:0.8f], [SKAction waitForDuration:0.5f]]];
    [self runAction:[SKAction repeatActionForever:flash]];
    
}

@end
