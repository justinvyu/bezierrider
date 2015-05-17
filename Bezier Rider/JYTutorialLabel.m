//
//  JYself.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/16/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYTutorialLabel.h"

@implementation JYTutorialLabel

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.fontSize = 20.0f;
        self.fontColor = [UIColor blackColor];
        self.name = @"tutorial";
    }
    
    return self;
}

@end
