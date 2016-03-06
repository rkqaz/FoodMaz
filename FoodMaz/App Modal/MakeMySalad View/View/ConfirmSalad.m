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

    
       
    
    [self _updateValues];
    
}

- (void)_updateValues
{

    [self addleftViewforTextField:self.saladName];

    FM_Log(@"Salad :%li",(long)[FM_SaladManager sharedManager].salad.price);
    self.price.text = [NSString stringWithFormat:@"%li AED",(long)[FM_SaladManager sharedManager].salad.price];
    
    
    FM_Log(@"Salad :%@",self.price.text);

    
    
    
}


- (void)addleftViewforTextField:(UITextField *)textField
{

    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, CGRectGetHeight(textField.frame))];
    leftview.backgroundColor = [UIColor clearColor];
    
    textField.leftView = leftview;
    textField.leftViewMode = UITextFieldViewModeAlways;
}
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

    [[FM_SaladManager sharedManager].salad setQuantity:[NSNumber numberWithInt:(int)[self.quanity.text integerValue]]];
}

- (IBAction)quantityDecrementBTNAction:(id)sender {
    
    
    if ([self.quanity.text integerValue] > 1)
    self.quanity.text = [NSString stringWithFormat:@"%i",(int)[self.quanity.text integerValue] - 1];

    self.price.text = [NSString stringWithFormat:@"%li AED",([self.quanity.text integerValue]) * [FM_SaladManager sharedManager].salad.price];
    
    [[FM_SaladManager sharedManager].salad setQuantity:[NSNumber numberWithInt:(int)[self.quanity.text integerValue]]];

    
    
}
@end
