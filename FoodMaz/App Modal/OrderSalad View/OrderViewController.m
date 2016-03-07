//
//  OrderSaladViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "OrderViewController.h"

#import "OrderTableViewCell.h"

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
    
    //left bar button item
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    

    
    self.totalPrice.text = [NSString stringWithFormat:@"%i AED",(int)[FM_SaladManager sharedManager].price];
    
    self.data = [NSArray arrayWithArray:[FM_SaladManager sharedManager].saladData];

}

#pragma mark - Button Actions

- (void)backButtonAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableview Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    OrderTableViewCell * cell = (OrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    //cellselectionstyle to NONE
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FM_Salad * salad = (FM_Salad *)self.data[indexPath.row];
    
    cell.saladName.text = salad.name;
    
    cell.price.text = [NSString stringWithFormat:@"%i",(int)salad.price];
    

    
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
    
    
    NSArray *salads = [[FM_SaladManager sharedManager] saladData];
    
    NSArray *array = [NSArray arrayWithArray:salads];

    
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray: array];
    
    for (FM_Salad *salad in countedSet) {
    
        NSLog(@"salsla:%@ +++ %d",salad.name,(int)[countedSet countForObject:salad]);
        
        //create Order Object
        PFObject * order = [PFObject objectWithClassName:@"Order"];
        
        //give name
        order[@"Name"] = salad.name;
        
        //give quantity
        order[@"Quantity"] = [NSNumber numberWithInt:(int)[countedSet countForObject:salad]];
        //Add User
        order[@"User"] = [PFUser currentUser].email;
        
        //Add status
        order[@"Status"] = @"Open";
        
        //customised
        order[@"Customised"] =  [NSNumber numberWithBool:salad.customised];
        
        if (salad.customised) {
        
            //add Ingredients
            NSArray *ingredients = [salad.ingredients valueForKey:@"name"];
            
            FM_Log(@"ingredients:%@",ingredients);
            
            order[@"Ingredients"] = ingredients;
            
            //Quantity
            order[@"Quantity"] = salad.quantity;
            
            //add Bed
            order[@"Bed"] = salad.bed[@"name"];
            
            //add Dressing
            order[@"Dressing"] = salad.dressing[@"name"];
        }

        //Upload data to Parse
        [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            if (succeeded) {
                
                [[FM_SaladManager sharedManager].saladData removeObjectIdenticalTo:salad];
                //Add Order relation to User
                PFUser *user = [PFUser currentUser];
                PFRelation *relation = [user relationForKey:@"Orders"];
                [relation addObject:order];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                    
                        FM_Log(@"Success");

                    } else {
                    
                        FM_Log(@"Error:%@",error.localizedDescription);

                    }
                }];
            } else {
                
                [self showAlertWithMessage:error.localizedDescription];
            }
        }];

        
    }
    
}
@end
