//
//  ConfirmSalad.h
//  FoodMaz
//
//  Created by Ravi Kiran on 3/2/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmSalad : UIView
@property (weak, nonatomic) IBOutlet UITextField *saladName;
@property (weak, nonatomic) IBOutlet UILabel *quanity;
@property (weak, nonatomic) IBOutlet UILabel *saladPrice;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *decrementButton;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;

- (IBAction)cancelBTNAction:(id)sender;

- (IBAction)quantityIncrementBTNAction:(id)sender;

- (IBAction)quantityDecrementBTNAction:(id)sender;

- (IBAction)addToBasketButtonAction:(id)sender;
@end
