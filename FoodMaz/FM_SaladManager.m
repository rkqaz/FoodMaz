//
//  FM_CustomSalad.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_SaladManager.h"

@implementation FM_SaladManager

+ (instancetype)sharedManager {
    static FM_SaladManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)checkValidationforSaladBed
{

    
    NSPredicate *saladBedPredicate = [NSPredicate predicateWithFormat:@"type == %@",kBed];
    
    NSArray *filterData = [self.saladData filteredArrayUsingPredicate:saladBedPredicate];
    
    if (filterData && filterData.count > 0) {
    
        if (filterData.count > 1) {
        
            //Display alert User can choose only 1 bed
        }
    } else {
    
        // store SaladBed Data
    }
}


- (void)checkValidationforSaladIngredients
{
    
    NSPredicate *saladBedPredicate = [NSPredicate predicateWithFormat:@"type == %@",kIngredient];

    NSArray *filterData = [self.saladData filteredArrayUsingPredicate:saladBedPredicate];
    
    if (filterData && filterData.count > 0) {
        
        if (filterData.count > 1) {
            
            //Display alert User can choose only 6 Ingredients
        }
    } else {
        
        // store SaladBed Data
    }

}

- (void)checkValidationforSaladDressing
{
    NSPredicate *saladBedPredicate = [NSPredicate predicateWithFormat:@"type == %@",kDressing];

    NSArray *filterData = [self.saladData filteredArrayUsingPredicate:saladBedPredicate];
    
    if (filterData && filterData.count > 0) {
        
        if (filterData.count > 1) {
            
            //Display alert User can choose only 1 Dressing
        }
    } else {
        
        // store Salad Dressing Data
    }

}

- (void)addSalad:(FM_Salad *)salad
{

}
@end
