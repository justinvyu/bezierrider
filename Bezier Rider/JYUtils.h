//
//  JYUtils.h
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface JYUtils : NSObject

#define SIZE(view) view.frame.size
#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define FRAME(view) view.frame
#define BOUNDS(view) view.bounds

#define FADE_DURATION 0.5f

extern const uint32_t ballCategory;
extern const uint32_t wallCategory;
extern const uint32_t curveCategory;
extern const uint32_t targetCategory;

+ (UIColor *)colorWithHexString:(NSString *)hex;

+ (void)fadeInView:(UIView *)view withDuration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;
+ (void)fadeOut:(UIView *)view withDuration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion;

+ (CGPoint)quadraticPointStartingAt:(CGPoint)p0 controlPoint:(CGPoint)p1 toPoint:(CGPoint)p2 t:(CGFloat)t;

+ (NSArray *)colorArray;

@end
