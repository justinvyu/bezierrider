//
//  SKButton.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/14/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <FlatUIKit/FlatUIKit.h>

@interface SKButton : SKShapeNode

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithPosition:(CGPoint)position size:(CGSize)size;

@property (nonatomic, strong) SKLabelNode *textLabel;

@property (nonatomic) BOOL enabled;

@end
