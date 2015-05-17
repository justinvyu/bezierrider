//
//  JYUtils.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYUtils.h"

#import <FlatUIKit/FlatUIKit.h>

@implementation JYUtils

const uint32_t ballCategory     =  0x1 << 0;
const uint32_t wallCategory     =  0x1 << 1;
const uint32_t curveCategory    =  0x1 << 2;
const uint32_t targetCategory   =  0x1 << 3;

+ (UIColor *)colorWithHexString:(NSString *)hex {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (void)fadeInView:(UIView *)view withDuration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
    
    view.alpha = 0.0f;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 1.0f;
    } completion:completion];
}

+ (void)fadeOut:(UIView *)view withDuration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
    
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 0.0f;
    } completion:completion];
}

+ (CGPoint)quadraticPointStartingAt:(CGPoint)p0 controlPoint:(CGPoint)p1 toPoint:(CGPoint)p2 t:(CGFloat)t {
    
    CGFloat x = powf(1 - t, 2) * p0.x + 2 * (1 - t) * t * p1.x + powf(t, 2) * p2.x;
    CGFloat y = powf(1 - t, 2) * p0.y + 2 * (1 - t) * t * p1.y + powf(t, 2) * p2.y;
    
    return CGPointMake(x, y);
}

+ (NSArray *)colorArray {
    
    return @[[UIColor blackColor], [UIColor turquoiseColor], [UIColor silverColor], [UIColor amethystColor], [UIColor sunflowerColor], [UIColor wetAsphaltColor]];
}

@end
