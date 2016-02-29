//
//  FM_Salad.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <Parse/Parse.h>

@interface FM_Salad : NSObject

//Bed
@property(null_resettable,nonatomic,strong)FM_SaladStack *bed;

//Ingredients
@property(nonnull,nonatomic,strong)NSMutableArray *ingredients;

//Dressing
@property(null_resettable,nonatomic,strong)FM_SaladStack *dressing;

//Customised
@property(nonatomic,assign)BOOL customised;

//Salad Stack

@property(nonnull,nonatomic,assign)FM_SaladStack *saladStack;

// Validate SaladStack

- (void)validatateSaladStack:(FM_SaladStack *)stackItem result:(void (^)(BOOL success,NSString *errorMessage))resultBlock;

//Delete Stackitem
- (void)deleteStackItem:(FM_SaladStack *)stackItem;
//Error Message
@property (nullable,nonatomic,retain)NSString *errorMessage;

@property (nonatomic,assign)NSInteger price;
@end
