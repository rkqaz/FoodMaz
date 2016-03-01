//
//  HomeViewController.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : FM_BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

//DeliveryToME Button
@property (weak, nonatomic) IBOutlet UIButton *delivertToMe;

//Basket Button
@property (weak, nonatomic) IBOutlet UIButton *basket;

//Price
@property (weak, nonatomic) IBOutlet UILabel *priceLBL;

//Deltvertome Button Action
- (IBAction)deliveryToMeAction:(UIButton *)sender;

//Basket Button Action
- (IBAction)basketBTNAction:(id)sender;

@end
