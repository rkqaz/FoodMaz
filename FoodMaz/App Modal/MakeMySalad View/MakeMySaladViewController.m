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

#import "FM_PopUP.h"


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
    
    //Initilaise Salad Object
    
    //Parse Query
    [self pullDataFromParse];
    
    //Add dash Border for HealthTipView
    [self.healthTipView.layer addSublayer:[self addDashedBorderWithColor:[FM_Color greenColor].CGColor]];
    
    
    //self.saladstackTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.navigationItem setTitle:@"CREATE YOUR OWN SALAD"];

    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;

    
    
}


#pragma mark - PARSE QUERY

- (void)pullDataFromParse
{
    //Query to pull data from Parse Server
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
    
    //cellselectionstyle to NONE
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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
    
    self.healthTipTextView.text = stack[@"HealthTip"];

    
}

- (void)errorinPickingStack:(NSString *)error
{

    [self showAlertWithMessage:error];
}

- (void)deSelectedStack:(FM_SaladStack *)stack
{
    FM_Log(@" %s Selected Stack:%@",__FUNCTION__,stack);
    
    FM_Salad *salad = [[FM_SaladManager sharedManager] salad];
   
    [salad deleteStackItem:stack];
    
    FM_Log(@"Salad Price:%i",(int)salad.price);
    [[FM_SaladManager sharedManager] setSalad:salad];


}



#pragma mark - Custom UI Methods

/*
 * Add Dash border
 */
- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGSize frameSize = CGSizeMake(CGRectGetWidth(self.healthTipView.frame), CGRectGetHeight(self.healthTipView.frame));
    
    CGRect shapeRect = CGRectMake(0.0f, 0.0f, frameSize.width, frameSize.height);
    [shapeLayer setBounds:shapeRect];
    [shapeLayer setPosition:CGPointMake( frameSize.width/2,frameSize.height/2)];
    
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:color];
    [shapeLayer setLineWidth:2.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],
      nil]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:5.0];
    [shapeLayer setPath:path.CGPath];
    
    return shapeLayer;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button Actions

- (void)backButtonAction
{
 
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)maktItForMeButonAction:(id)sender {
    
    CGRect _frame = [UIApplication sharedApplication].keyWindow.frame;
    
    _frame.origin.y = 0.0f;
    
   // _frame.size.height += 64.0f;
    

    FM_PopUP * popUp = [[FM_PopUP alloc] initWithFrame:_frame];
    
    [self.view addSubview:popUp];

    return;
    FM_Salad *salad = [[FM_SaladManager sharedManager] salad];
    
    if (salad) {
    
        [salad performValidationOnSalad:^(NSString *errorMessage) {
            
            if(errorMessage) {
            
                [self showAlertWithMessage:errorMessage];
            } else {
            
                FM_PopUP * popUp = [[FM_PopUP alloc] initWithFrame:_frame];
                
                [[[UIApplication sharedApplication] keyWindow] addSubview:popUp];
                
               }
        }];
    } else {
    
        [self showAlertWithMessage:@"Please select Ingredients"];
    }
}
@end
