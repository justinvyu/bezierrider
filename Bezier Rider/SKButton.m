//
//  SKButton.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/14/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "SKButton.h"

@implementation SKButton

- (instancetype)initWithPosition:(CGPoint)position size:(CGSize)size {
    
    if (self = [super init]) {
        
        self.position = position;
        [self setPath:CGPathCreateWithRoundedRect(CGRectMake(-size.width/2, -size.height/2, size.width, size.height), 4, 4, nil)];
                
        self.fillColor = [UIColor peterRiverColor];
        self.strokeColor = [UIColor peterRiverColor];
        self.lineWidth = 2.0f;
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    
    SKLabelNode *textLabel = [SKLabelNode labelNodeWithText:text];
    textLabel.fontSize = 20.0;
    textLabel.fontName = @"HelveticaNeue-Bold";
    textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    [self addChild:textLabel];
    textLabel.position = CGPointMake(0, 0);
    textLabel.name = self.name;
    _textLabel = textLabel;
}

- (void)setImage:(UIImage *)image {
    
    SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:image] size:CGSizeMake(30., 30.)];
    imageNode.name = self.name;
    [self addChild:imageNode];
}

- (void)setEnabled:(BOOL)enabled {
    
    if (enabled) {
        self.fillColor = [UIColor peterRiverColor];
        self.strokeColor = [UIColor peterRiverColor];
    } else {
        self.fillColor = [UIColor concreteColor];
        self.strokeColor = [UIColor concreteColor];
    }
}

@end
