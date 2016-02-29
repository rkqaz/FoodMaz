//
//  MakeMySaladViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "MakeMySaladViewController.h"

#define kCellIdentifier @"SaladCellIdentifier"

#define kRowHeight 155.0f;

#import "FM_SaladManager.h"


#import "SaladTableViewCell.h"

@interface MakeMySaladViewController ()

@property (nonatomic,strong)NSArray *saladStackdata; //<-- Metadata from Parse
@end

@implementation MakeMySaladViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //register Nib for Tableview
    [self.saladstackTable registerNib:[UINib nibWithNibName:@"SaladTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    
    PFQuery *query = [PFQuery queryWithClassName:@"SaladStacks"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            FM_Log(@"Objects:%@",objects);
            
            //assign result
            self.saladStackdata = objects;
            
            //reload table
            [self.saladstackTable reloadData];
        } else {
            // Log details of the failure
            FM_Log(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    self.salad = [[FM_Salad alloc] init];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return kRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

   // NSArray *data = [self dataforRow:0];
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SaladTableViewCell * cell = (SaladTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    //get Data for row
    NSArray *data = [self dataforRow:(NSInteger)indexPath.row];
    
    //assign data
    [cell.saladStackScrollView performLoadWithData:data];
    
    //assaign delegate to self
    cell.saladStackScrollView.FM_ScrollDelegate = self;
    
    
    return cell;
}


#pragma Convenience Methods

- (NSArray *)dataforRow:(NSInteger )row

{

    //Apply filter based on row
    
    NSPredicate *filterPrdicate;
    
    switch (row) {
        case 0: //<-- Bed
         {
         
             filterPrdicate = [NSPredicate predicateWithFormat:@"type == %@",kBed];
         }
            break;
        case 1: //<--- Ingredient
         {
             filterPrdicate = [NSPredicate predicateWithFormat:@"type == %@",kIngredient];

         }
            break;

        case 2: //<-- Dressing
         {
             filterPrdicate = [NSPredicate predicateWithFormat:@"type == %@",kDressing];

         }
            break;

            
        default:
            break;
    }
    
    //filter using predicate
    NSArray *filteredData = [self.saladStackdata filteredArrayUsingPredicate:filterPrdicate];
    
    //return data
    return filteredData;
}


#pragma mark - FM_Scrollview Delegate Methods

- (void)selectedStack:(FM_SaladStack *)stack
{
    

   FM_Log(@" %s Selected Stack:%@",__FUNCTION__,stack);
    
    ///if (![[FM_SaladManager sharedManager] salad]) {
    
    
        [self.salad validatateSaladStack:stack result:^(BOOL success, NSString *errorMessage) {
            
            if (!success) {
                
                [self showAlertWithMessage:errorMessage];
            }
        }];

    FM_Log(@"Salad Price:%i",(int)self.salad.price);

    [[FM_SaladManager sharedManager] setSalad:self.salad];
    //}
    
    
}

- (void)deSelectedStack:(FM_SaladStack *)stack
{
    FM_Log(@" %s Selected Stack:%@",__FUNCTION__,stack);
    
    self.salad = [[FM_SaladManager sharedManager] salad];
   
    [self.salad deleteStackItem:stack];
    
    FM_Log(@"Salad Price:%i",(int)self.salad.price);
    [[FM_SaladManager sharedManager] setSalad:self.salad];


}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
