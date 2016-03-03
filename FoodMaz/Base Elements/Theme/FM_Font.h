//
//  FM_Font.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FM_Font : NSObject

+(UIFont *)labelFont;

+(UIFont *)regularFont;

+(UIFont *)regularFontWithSize:(int)size;

+(UIFont *)labelFontWithSize:(int)size;
@end
