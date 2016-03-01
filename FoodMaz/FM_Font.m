//
//  FM_Font.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_Font.h"

#define k_BOLD_FONT @"Menlo-Bold"

#define k_REGULAR_FONT @"Menlo"

@implementation FM_Font

+(UIFont *)labelFont
{

    return [UIFont fontWithName:k_BOLD_FONT size:13];
}

+(UIFont *)labelFontWithSize:(int)size
{
    
    return [UIFont fontWithName:k_BOLD_FONT size:size];
}

+(UIFont *)regularFont
{

    return [UIFont fontWithName:k_REGULAR_FONT size:13];

}

+(UIFont *)regularFontWithSize:(int)size
{
    
    return [UIFont fontWithName:k_REGULAR_FONT size:size];
    
}

@end
