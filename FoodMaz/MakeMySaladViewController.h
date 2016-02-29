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

@property (nonatomic,strong)FM_Salad *salad;
@end
