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

//Error Message
@property (nullable,nonatomic,retain)NSString *errorMessage;

//Salad Price
@property (nonatomic,assign)NSInteger price;

//Salad Name

@property (null_resettable,nonatomic,strong)NSString *name;

//SaladImage

@property(nullable,nonatomic,strong)PFFile *imageFile;
// Validate SaladStack

- (void)validatateSaladStack:(nonnull FM_SaladStack *)stackItem result:(nullable void (^)(BOOL success, NSString  * _Nonnull errorMessage))resultBlock;

//Delete Stackitem
- (void)deleteStackItem:(nonnull FM_SaladStack *)stackItem;

//validation on Salad
- (void)performValidationOnSalad:(nullable void(^)(NSString * _Nullable errorMessage))result;


@end
