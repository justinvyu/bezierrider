//
//  JYStageButton.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/13/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <FlatUIKit/FlatUIKit.h>

@interface JYStageButton : FUIButton

- (instancetype)initWithPosition:(CGPoint)position size:(CGSize)size text:(NSString *)text;

@property (nonatomic) NSInteger stage; // 0 - 4 0 = tutorial; 4 = level 4

@end
