//
//  FM_PopUP.m
//  FoodMaz
//
//  Created by Ravi Kiran on 3/3/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_PopUP.h"

#import "ConfirmSalad.h"

@implementation FM_PopUP

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        [self _UIsetUp];

    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self _UIsetUp];
    }
    
    return self;
}

- (void)_UIsetUp
{

    
    self.backgroundColor = [UIColor lightGrayColor];
    
    

        float width = 320;
        
        float height = 300;

        self.confirmSaladView = [ [ [ NSBundle mainBundle ] loadNibNamed:@"ConfirmSalad" owner:self options:nil ] firstObject ];
        
        [self.confirmSaladView setFrame:CGRectMake((CGRectGetWidth(self.frame) - width)/2, (CGRectGetHeight(self.frame) - height)/2 - 30, width, height)];
        
        
        [self.confirmSaladView.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        //[self.confirmSaladView.addToBasket addTarget:self action:@selector(addtoBasketButtonAction) forControlEvents:UIControlEventTouchUpInside];

        
        [self addSubview:self.confirmSaladView];
        
    
    

}

#pragma mark - ButtonAction

- (void)cancelButtonAction
{

    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.confirmSaladView = nil;
    
    [self removeFromSuperview ];
}

- (void)addtoBasketButtonAction
{
    
    //Add to Salad data based on quantity
    

    NSInteger quantity = [[FM_SaladManager sharedManager].salad.quantity integerValue];
    
    for (int i = 0; i < quantity; i ++) {
        
        [[[FM_SaladManager sharedManager] saladData] addObject:[FM_SaladManager sharedManager].salad];

    }
    
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview ];
    

   // [[[[[UIApplication sharedApplication]keyWindow] rootViewController] navigationController] popViewControllerAnimated:YES];
    
}
@end
