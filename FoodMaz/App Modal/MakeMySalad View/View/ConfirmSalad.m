//
//  ConfirmSalad.m
//  FoodMaz
//
//  Created by Ravi Kiran on 3/2/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "ConfirmSalad.h"

@implementation ConfirmSalad



- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        [self _addUIforElement];
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self _addUIforElement];
    }
    
    return self;
}

- (void)_addUIforElement
{

    /**
     * Cancel button
     */
    self.cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.cancelButton.layer.borderWidth = 1.2;
    
    self.cancelButton.layer.cornerRadius = CGRectGetWidth(self.cancelButton.frame)/2;
    
    
    /**
     * Increment button
     */
    self.incrementButton.layer.borderColor = [UIColor redColor].CGColor;
    
    self.incrementButton.layer.borderWidth = 1.2;
    
    self.incrementButton.layer.cornerRadius = 20;
    
    /**
     * Decrement button
     */
    self.decrementButton.layer.borderColor = [self.decrementButton titleColorForState:UIControlStateNormal].CGColor;
    
    self.decrementButton.layer.borderWidth = 1.2;
    
    self.decrementButton.layer.cornerRadius = CGRectGetWidth(self.decrementButton.frame)/2;
    

}

#pragma mark - Button Actions
- (IBAction)cancelBTNAction:(id)sender {
    
    [self removeFromSuperview];
    
    [self.superview removeFromSuperview];
    
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
