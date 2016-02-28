//
//  FM_Color.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_Color.h"

@implementation FM_Color

/**
 *@author Ravi Kiran
 *
 * Get Color from Hex String
 * @parm Hexstring -> color code
 * @return Color
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

/*
 * Green Color
 */
+ (UIColor *)greenColor
{
    
    return [self colorFromHexString:@"#84C71C"];
}
@end
