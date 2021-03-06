//
//  ConfirmSalad.h
//  FoodMaz
//
//  Created by Ravi Kiran on 3/2/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * ConfirmSaladDelegate Delegate
 */
@protocol ConfirmSaladDelegate <NSObject>

- (void)confirmSaladSuccess;

- (void)errorInconfirmSalad:(NSString *)error;

@end

@interface ConfirmSalad : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *saladName;
@property (weak, nonatomic) IBOutlet UILabel *quanity;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *decrementButton;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addToBasket;

@property (assign, nonatomic) id<ConfirmSaladDelegate> ConfirmSaladDelegate;

- (IBAction)cancelBTNAction:(id)sender;

- (IBAction)quantityIncrementBTNAction:(id)sender;

- (IBAction)quantityDecrementBTNAction:(id)sender;

@end
