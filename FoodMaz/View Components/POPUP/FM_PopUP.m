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

        ConfirmSalad *confirmSalad = [ [ [ NSBundle mainBundle ] loadNibNamed:@"ConfirmSalad" owner:self options:nil ] firstObject ];
        
        [confirmSalad setFrame:CGRectMake((CGRectGetWidth(self.frame) - width)/2, (CGRectGetHeight(self.frame) - height)/2 - 30, width, height)];
        
        
        [confirmSalad.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [confirmSalad.addToBasket addTarget:self action:@selector(addtoBasketButtonAction) forControlEvents:UIControlEventTouchUpInside];

        
        [self addSubview:confirmSalad];
        
    
    

}

#pragma mark - ButtonAction

- (void)cancelButtonAction
{

    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview ];
}

- (void)addtoBasketButtonAction
{
    
    [[[FM_SaladManager sharedManager] saladData] addObject:[FM_SaladManager sharedManager].salad];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview ];

}
@end
