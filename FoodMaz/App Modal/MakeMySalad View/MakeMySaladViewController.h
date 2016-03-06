//
//  MakeMySaladViewController.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FM_ScrollView.h"


@interface MakeMySaladViewController : FM_BaseViewController<UITableViewDataSource,UITableViewDelegate,FM_ScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *saladstackTable;
@property (weak, nonatomic) IBOutlet UITextView *healthTipTextView;

@property (weak, nonatomic) IBOutlet UIView *healthTipView;

- (IBAction)maktItForMeButonAction:(id)sender;

@end
