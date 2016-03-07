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
        
        [self constructUI];

    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self constructUI];

    }
    
    return self;
}

- (void)constructUI{

    
    dispatch_async(dispatch_get_main_queue(), ^{

       [self _addUIforElement];
    });
       


}
- (void)_addUIforElement
{

    /**
     * Cancel button
     */
    self.cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.cancelButton.layer.borderWidth = 2;
    
    self.cancelButton.layer.cornerRadius = CGRectGetWidth(self.cancelButton.frame)/2;
    
    
    /**
     * Increment button
     */
    self.incrementButton.layer.borderColor = [self.decrementButton titleColorForState:UIControlStateNormal].CGColor;
    
    self.incrementButton.layer.borderWidth = 3;
    
    self.incrementButton.layer.cornerRadius = CGRectGetWidth(self.incrementButton.frame)/2;
    
    /**
     * Decrement button
     */
    self.decrementButton.layer.borderColor = [self.decrementButton titleColorForState:UIControlStateNormal].CGColor;
    
    self.decrementButton.layer.borderWidth = 3;
    
    self.decrementButton.layer.cornerRadius = CGRectGetWidth(self.decrementButton.frame)/2;
    

    self.price.text = [NSString stringWithFormat:@"%li",(long)[FM_SaladManager sharedManager].salad.price];

    self.quanity.text = @"1";
       
    [[FM_SaladManager sharedManager].salad setQuantity:[NSNumber numberWithInt:1]];

    
    FM_Log(@"Quanity:%li",(long)[[FM_SaladManager sharedManager].salad.quantity integerValue]);

   // [self _updateValues];
    
    [self addleftViewforTextField:self.saladName];
    
    self.price.text = [NSString stringWithFormat:@"%li AED",(long)[FM_SaladManager sharedManager].salad.price];

    
    [self.addToBasket addTarget:self action:@selector(addToBasketAction) forControlEvents:UIControlEventTouchUpInside];

}


- (void)addToBasketAction
{
    
    if(self.saladName.text.length > 0) {
    
        
        //Add to Salad data based on quantity
        
        NSInteger quantity = [[FM_SaladManager sharedManager].salad.quantity integerValue];
        
        for (int i = 0; i < quantity; i ++) {
            
            [[[FM_SaladManager sharedManager] saladData] addObject:[FM_SaladManager sharedManager].salad];
            
        }
        

        if (self.ConfirmSaladDelegate && [self.ConfirmSaladDelegate respondsToSelector:@selector(confirmSaladSuccess)]) {
            
            
            [self.ConfirmSaladDelegate confirmSaladSuccess];
            
        }
        
    } else {
    
    
        if (self.ConfirmSaladDelegate && [self.ConfirmSaladDelegate respondsToSelector:@selector(errorInconfirmSalad:)]) {
            
            
            [self.ConfirmSaladDelegate errorInconfirmSalad:@"Please name your salad"];
            
        }

    }

    

}

- (void)_updateValues
{


    FM_Log(@"Salad :%li",(long)[FM_SaladManager sharedManager].salad.price);
    
    
    FM_Log(@"Salad :%@",self.price.text);
    
}


- (void)addleftViewforTextField:(UITextField *)textField
{

    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, CGRectGetHeight(textField.frame))];
    leftview.backgroundColor = [UIColor clearColor];
    
    textField.leftView = leftview;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - UITextField Delegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    self.saladName.text = textField.text;
    
    [FM_SaladManager sharedManager].salad.name = self.saladName.text;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Button Actions
- (IBAction)cancelBTNAction:(id)sender {
    
    
    [self removeFromSuperview];
    
    [self.superview removeFromSuperview];
    
}
- (IBAction)quantityIncrementBTNAction:(id)sender {
    
    self.quanity.text = [NSString stringWithFormat:@"%i",(int)[self.quanity.text integerValue] + 1];
    
    
    self.price.text = [NSString stringWithFormat:@"%li AED",([self.quanity.text integerValue]) * [FM_SaladManager sharedManager].salad.price];

    NSInteger quantity = [[FM_SaladManager sharedManager].salad.quantity integerValue];

    [[FM_SaladManager sharedManager].salad setQuantity:[NSNumber numberWithInt:(int)(quantity + 1)]];
    
    
    FM_Log(@"Quanity:%li",(long)[[FM_SaladManager sharedManager].salad.quantity integerValue]);

}

- (IBAction)quantityDecrementBTNAction:(id)sender {
    
    
    if ([self.quanity.text integerValue] > 1) {
    
        self.quanity.text = [NSString stringWithFormat:@"%i",(int)[self.quanity.text integerValue] - 1];
        
        self.price.text = [NSString stringWithFormat:@"%li AED",([self.quanity.text integerValue]) * [FM_SaladManager sharedManager].salad.price];
        
        NSInteger quantity = [[FM_SaladManager sharedManager].salad.quantity integerValue];
        
        [[FM_SaladManager sharedManager].salad setQuantity:[NSNumber numberWithInt:(int)(quantity - 1)]];
        
        
        FM_Log(@"Quanity:%li",(long)[[FM_SaladManager sharedManager].salad.quantity integerValue]);

    }


    
    
}
@end
