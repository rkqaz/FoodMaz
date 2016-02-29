//
//  FM_Constants.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#ifndef FM_Constants_h
#define FM_Constants_h

#define kBed @"Bed"

#define kIngredient @"Ingredient"

#define kDressing @"Dressing"

//[[NSString stringWithUTF8String:__FILE__] lastPathComponent]
#define FM_Log( s, ... ) NSLog( @"<%s: LINE %d > %@", __PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__])


#define kSHOWALERT_NOTIFICATION @"Alert Notication"


#define k_SHOWALERT_MESSAGE @"Alert Message"
#endif /* FM_Constants_h */
