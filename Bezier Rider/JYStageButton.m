//
//  JYStageButton.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/13/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYStageButton.h"

@implementation JYStageButton

- (instancetype)initWithPosition:(CGPoint)position size:(CGSize)size text:(NSString *)text {
    
    if (self = [super initWithFrame:CGRectMake(position.x - size.width / 2, position.y - size.height / 2, size.width, size.height)]) {
        
        self.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self setTitle:text forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.buttonColor = [UIColor turquoiseColor];
        self.shadowColor = [UIColor greenSeaColor];
        self.shadowHeight = 3.0f;
        self.cornerRadius = 6.0f;
    }
    
    return self;
}

@end
