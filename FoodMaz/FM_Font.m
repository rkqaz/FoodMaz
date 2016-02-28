//
//  FM_Font.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_Font.h"

@implementation FM_Font

+(UIFont *)labelFont
{

    return [UIFont fontWithName:@"Menlo-Bold" size:13];
}

+(UIFont *)labelFontWithSize:(int)size
{
    
    return [UIFont fontWithName:@"Menlo-Bold" size:size];
}
@end
