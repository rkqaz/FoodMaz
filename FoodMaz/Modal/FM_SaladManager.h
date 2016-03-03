//
//  FM_CustomSalad.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FM_Salad.h"

@interface FM_SaladManager : NSObject

@property (nonatomic,strong)NSMutableArray *saladData;

@property (nonatomic,retain)FM_Salad *salad;

@property (nonatomic,assign)NSInteger price;
+ (instancetype)sharedManager;

- (void)addSalad:(FM_Salad *)salad;

@end
