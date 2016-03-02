//
//  ConfirmSalad.h
//  FoodMaz
//
//  Created by Ravi Kiran on 3/2/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmSalad : UIView
- (IBAction)cancelBTNAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *saladName;
- (IBAction)quantityIncrementBTNAction:(id)sender;
- (IBAction)quantityDecrementBTNAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *quanity;
@property (weak, nonatomic) IBOutlet UILabel *saladPrice;
- (IBAction)addToBasketButtonAction:(id)sender;
@end
