//
//  OrderSaladViewController.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : FM_BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)delivertoMeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UILabel *orderSummary;
@property (weak, nonatomic) IBOutlet UITextView *orderInstructions;
@property (weak, nonatomic) IBOutlet UIView *totalPriceView;
@property (weak, nonatomic) IBOutlet UITableView *orderTable;
@end
