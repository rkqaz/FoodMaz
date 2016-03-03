//
//  SaladTableViewCell.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FM_ScrollView.h"

@interface SaladTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet FM_ScrollView *saladStackScrollView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
