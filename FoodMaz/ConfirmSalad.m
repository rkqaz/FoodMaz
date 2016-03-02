//
//  ConfirmSalad.m
//  FoodMaz
//
//  Created by Ravi Kiran on 3/2/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "ConfirmSalad.h"

@implementation ConfirmSalad

- (IBAction)cancelBTNAction:(id)sender {
    
    [self removeFromSuperview];
    
}
- (IBAction)quantityIncrementBTNAction:(id)sender {
    
    
    self.quanity.text = [NSString stringWithFormat:@"%i",(int)[self.quanity.text integerValue] + 1];
    
}

- (IBAction)quantityDecrementBTNAction:(id)sender {
    
    
    if ([self.quanity.text integerValue] > 1)
    self.quanity.text = [NSString stringWithFormat:@"%i",(int)[self.quanity.text integerValue] - 1];

}
- (IBAction)addToBasketButtonAction:(id)sender {
    
    [[[FM_SaladManager sharedManager] saladData] addObject:[FM_SaladManager sharedManager].salad];
}
@end
