//
//  FM_Salad.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_Salad.h"

#define isBED(type) [type isEqualToString:kBed]

#define isIngredient(type) [type isEqualToString:kIngredient]

#define isDressing(type) [type isEqualToString:kDressing]



@implementation FM_Salad


@synthesize bed,ingredients,dressing,customised,name;


+(void)load
{

}
- (BOOL)checkValidationforSaladBed
{
    
    
    //NSPredicate *saladBedPredicate = [NSPredicate predicateWithFormat:@"type == %@",kBed];
    
    BOOL valid = NO;

    FM_Log(@"BED:%@",self.bed);
    if (self.bed && (nil != self.bed)) {
        
        
            //Display alert User can choose only 1 bed
        
       // [[NSNotificationCenter defaultCenter] postNotificationName:kSHOWALERT_NOTIFICATION object:nil userInfo:@{k_SHOWALERT_MESSAGE:@"You have already selected 6 ingredients.  Please unselect the selceted and select new"}];
        valid = NO;

        self.errorMessage = @"You have already selected BED.  Please unselect the selceted and select new";

    } else {
        
        // store SaladBed Data
        
        self.bed =  self.saladStack;
        
        valid = YES;
        
        //Update Salad Price
        self.price += [self.bed[@"Price"] integerValue];


    }
    
    FM_Log(@"Bed:%@",self.bed);

    return valid;
}


- (BOOL)checkValidationforSaladIngredients
{
    if (!self.ingredients) {
    
        self.ingredients = [[NSMutableArray alloc] init];
    }
    
    //NSPredicate *saladBedPredicate = [NSPredicate predicateWithFormat:@"type == %@",kIngredient];
    BOOL valid = NO;
 
   // NSArray *filterData = [self.ingredients filteredArrayUsingPredicate:saladBedPredicate];
    
    if (self.ingredients && self.ingredients.count > 0) {
        
        if (self.ingredients.count >= 6) {
            
            //Display alert User can choose only 6 Ingredients
            
           // [[NSNotificationCenter defaultCenter] postNotificationName:kSHOWALERT_NOTIFICATION object:nil userInfo:@{k_SHOWALERT_MESSAGE:@"You have already selected 6 ingredients.  Please unselect the selceted and select new"}];
            
            self.errorMessage = @"You have already selected 6 INGREDIENTS.  Please unselect the selceted and select new";

        } else {
        
            // store SaladIngredient Data
            if(![self.ingredients containsObject:self.saladStack]) //<-- to remove duplicates
                [self.ingredients addObject:self.saladStack];
            
            valid = YES;
            //Update Salad Price
            self.price += [self.saladStack[@"Price"] integerValue];

        }
        
    } else {
        
        // store SaladIngredient Data
        if(![self.ingredients containsObject:self.saladStack]) //<-- to remove duplicates
        [self.ingredients addObject:self.saladStack];
        
        valid = YES;
        
        //Update Salad Price
        self.price += [self.saladStack[@"Price"] integerValue];

    }
    
    FM_Log(@"Ingredients:%d",(int)self.ingredients.count);
    
    return valid;
}

- (BOOL)checkValidationforSaladDressing
{
    //NSPredicate *saladBedPredicate = [NSPredicate predicateWithFormat:@"type == %@",kDressing];
    
    
    BOOL valid = NO;
    
    //SArray *filterData = [self.saladData filteredArrayUsingPredicate:saladBedPredicate];
    
    if (self.dressing && nil != self.dressing) {
        
        
        //Display alert User can choose only 1 Dressing
        
       // [[NSNotificationCenter defaultCenter] postNotificationName:kSHOWALERT_NOTIFICATION object:nil userInfo:@{k_SHOWALERT_MESSAGE:@"You have already selected Dressing.  Please unselect the selceted and select new"}];

        self.errorMessage = @"You have already selected Dressing.  Please unselect the selceted and select new";
        
        valid = NO;
    } else {
        
        // store Salad Dressing Data
        self.dressing = self.saladStack;
        
        valid = YES;
        
        //Update Salad Price
        self.price += [self.dressing[@"Price"] integerValue];

    }
    
    FM_Log(@"Dressing:%@",self.dressing);

    return valid;
}

//Validate
- (void)validatateSaladStack:(FM_SaladStack *)stackItem result:(void (^)(BOOL success,NSString *errorMessage))resultBlock

{
    
    self.saladStack = stackItem;
    
    NSString *type = stackItem[@"type"];
    
    BOOL errored = NO;

    if (isBED(type)) { //<-- Bed
    
        FM_Log(@"Bed");
        
        errored = [self checkValidationforSaladBed];
    } else if(isIngredient(type)) { //<-- Ingredient
    

       errored = [self checkValidationforSaladIngredients];

        FM_Log(@"ingredients");

    } else { //<-- Dressing
    
        FM_Log(@"Dressing");
        
       errored = [self checkValidationforSaladDressing];

    }
    
    FM_Log(@"errored :%d",errored);

    resultBlock(errored,self.errorMessage);
}

- (void)deleteStackItem:(FM_SaladStack *)stackItem
{
    self.saladStack = stackItem;
    
    NSString *type = stackItem[@"type"];

    if (isBED(type)) { //<-- Bed
        
        FM_Log(@"Bed");
        
        self.bed = nil;
        
        self.price -= [stackItem[@"Price"] integerValue];
        
    } else if(isIngredient(type)) { //<-- Ingredient
        
        if ([self.ingredients containsObject:stackItem]) {
        
            [self.ingredients removeObject:stackItem];
            
            self.price -= [stackItem[@"Price"] integerValue];
        }
        
        FM_Log(@"Ingredients");
        
    } else { //<-- Dressing
        
        FM_Log(@"Dressing");
        
        self.dressing = nil;
        
        self.price -= [stackItem[@"Price"] integerValue];

    }

}


- (void)performValidationOnSalad:(void(^)(NSString *errorMessage))result {

    NSString *message = nil;
    if (nil == self.bed || !self.bed) {
    
        message = @"Please select Bed";
    } else if (self.ingredients && self.ingredients.count < 6) {
    
     message = @"Please select minimum 6 Ingredients";
        
    } else if (nil == self.dressing || !self.dressing) {
    
        message = @"Please select Dressing";
    }
    
    FM_Log(@"Salad Price:%i",(int)self.price);
    result(message);
}





@end
