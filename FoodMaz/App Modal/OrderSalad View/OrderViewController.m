//
//  OrderSaladViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "OrderViewController.h"


#define kCellIdentifier @"OrderCellIdentifier"

@interface OrderViewController ()

@property (nonatomic,retain)NSArray *data;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self.orderSummary.layer addSublayer:[self addDashedBorderWithColor:[FM_Color greenColor].CGColor forFrame:self.orderSummary.frame]];
 
    [self.totalPriceView.layer addSublayer:[self addDashedBorderWithColor:[FM_Color greenColor].CGColor forFrame:self.totalPriceView.frame]];

    [self.navigationItem setTitle:@"ORDER INSTRUCTIONS"];
    
    
    self.data = [NSArray array];

}


#pragma mark - UITableview Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    //cellselectionstyle to NONE
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)delivertoMeAction:(UIButton *)sender {
}
@end
