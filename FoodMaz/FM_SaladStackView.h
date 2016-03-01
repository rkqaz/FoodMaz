//
//  FM_SaladStackView.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * FM_StackView Delegate
 */
@protocol FM_StackViewDelegate <NSObject>

- (void)selectedStackItem:(FM_SaladStack *)stack;
- (void)deSelectedStackItem:(FM_SaladStack *)stack;
- (void)errorMessageInPickingSaladStack:(NSString *)errorMessage;


@end

@interface FM_SaladStackView : UIView

@property (nonatomic,assign)BOOL selected;

@property (nonatomic,strong)PFImageView *imgView;

@property (nonatomic,strong)FM_SaladStack *saladStack;

@property (assign, nonatomic) id<FM_StackViewDelegate> FM_SaladViewDelegate;

- (void)buildUIWithSaladStack:(FM_SaladStack *)stack;



@end
