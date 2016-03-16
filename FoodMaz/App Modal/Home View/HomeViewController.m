//
//  HomeViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "HomeViewController.h"

#define kSegue_MakeMySalad @"push_MakeMySalad"

#define kCellIdentifier @"SaladCellIdentifier"

@interface HomeViewController ()

@property (nonatomic,retain)NSMutableArray *salads;

@property (nonatomic,strong)PFImageView*selectedSaladImage;

@property (nonatomic,assign)CGPoint refPoint;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
//    self.menuButton .target = self.revealViewController;
//        self.menuButton.action = @selector(revealToggle:);
//    
//    // Set the gesture
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    
//
    

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_Bar.png"]];

    
    [[UINavigationBar appearance] setBarTintColor:[FM_Color greenColor]];
    
    [[UINavigationBar appearance] setTintColor:[FM_Color greenColor]];

    self.delivertToMe.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    self.delivertToMe.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    [self.delivertToMe setTitle: @"DELIVER\nTO ME" forState: UIControlStateNormal];
    
    
    
    
    [self _settotalPrice];

    [self _loadSaladData];
    
    self.salads = [[NSMutableArray alloc] init];
    
    
    
    self.selectedSaladImage = [[PFImageView alloc] init];
    
    [self.view addSubview:self.selectedSaladImage];
    
    self.selectedSaladImage.hidden = YES;
    
    
    //set CurrentUser to Installation Object
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    [currentInstallation setObject:[PFUser currentUser] forKey:@"User"];
    [currentInstallation saveInBackground];
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self updateBasket];
}
- (void)_loadSaladData
{

    //Query to pull data from Parse Server
    PFQuery *query = [PFQuery queryWithClassName:@"Salad"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            FM_Log(@"Objects:%@",objects);
            
            //Loop result
            [objects enumerateObjectsUsingBlock:^(PFObject *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                FM_Salad *salad = [[FM_Salad alloc] init];
                salad.customised = NO;
                salad.price = [obj[@"Price"] integerValue];
                salad.name = obj[@"Name"];
                salad.imageFile = obj[@"Image"];
                
                
                //assign salad

                [self.salads addObject:salad];

                
                
            }];
            //self.salads = objects;
            
            
            
            //reload table
            [self.saladCollectionView reloadData];
        } else {
            // Log details of the failure
            FM_Log(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

}
- (void)_settotalPrice
{

    NSString *priceStr = [NSString stringWithFormat:@"TOTAL\n%i\nAED",[FM_SaladManager sharedManager].saladData.count == 0 ? (int)0 :(int)[[FM_SaladManager sharedManager] price]];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    
    [attributedStr addAttribute:NSFontAttributeName value:[FM_Font labelFontWithSize:25] range:NSMakeRange(0,[attributedStr string].length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[FM_Color greenColor] range:NSMakeRange(0,[attributedStr string].length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[attributedStr string] rangeOfString:@"TOTAL"]];
    
    [attributedStr addAttribute:NSFontAttributeName value:[FM_Font regularFontWithSize:14.0f] range:[[attributedStr string] rangeOfString:@"TOTAL"]];
    [attributedStr addAttribute:NSFontAttributeName value:[FM_Font regularFontWithSize:14.0f] range:[[attributedStr string] rangeOfString:@"AED"]];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[FM_Color greenColor] range:[[attributedStr string] rangeOfString:@"AED"]];
    
    
    self.priceLBL.attributedText = attributedStr;

}



- (void)updateBasket
{

    NSString *numberofSalads = [NSString stringWithFormat:@"%i",(int)[[FM_SaladManager sharedManager].saladData count]];
    
    [self.basket setTitle:numberofSalads forState:UIControlStateNormal];
    
    [self _settotalPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.salads.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = kCellIdentifier;
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    PFImageView *saladImageView = (PFImageView *)[cell viewWithTag:100];
    
    
    
    saladImageView.userInteractionEnabled = YES;
    
    FM_Salad *salad = (FM_Salad *)self.salads[indexPath.row];
    
    saladImageView.tag = indexPath.row;
    //Add file
    saladImageView.file = (PFFile *)salad.imageFile; // remote image
    //Load Image inBackground
    [saladImageView loadInBackground];
    
    UILabel *price = (UILabel *)[cell viewWithTag:11];
    
    price.text = [NSString stringWithFormat:@"%i",(int)salad.price];
    UILabel *name = (UILabel *)[cell viewWithTag:22];
    name.text = salad.name;
    
    [cell.layer addSublayer:[self addDashedBorderWithColor:[FM_Color greenColor].CGColor forFrame:cell.frame]];
    
    [self addLongPressGestureRecognizerforView:saladImageView];
    
    return cell;
}


- (void)addLongPressGestureRecognizerforView:(PFImageView *)imageView
{
 
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    
    longPressGesture.minimumPressDuration = 0.75
;
    
    [imageView addGestureRecognizer:longPressGesture];
    
}

- (void)longPressGesture:(UIGestureRecognizer *)gesture
{
    
    

    CGRect frame = [gesture.view.superview convertRect:gesture.view.bounds toView:self.view];
    
    self.refPoint = CGPointMake(frame.origin.x, frame.origin.y);
    
    PFImageView *imView = (PFImageView *)gesture.view;
    
    self.selectedSaladImage.image = imView.image;
    
    self.selectedSaladImage.tag = imView.tag;
    self.selectedSaladImage.hidden = NO;
    
    self.selectedSaladImage.frame = frame;
    FM_Log(@"Frame:%@",NSStringFromCGRect(frame));
    
    [self.view bringSubviewToFront:self.selectedSaladImage];
    
    
    
    switch ([gesture state])
    {
        case UIGestureRecognizerStateBegan:
           // [self startDragging:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self doDrag:gesture];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self stopDragging:gesture];
            break;
        default:
            break;
    }
    
}

- (void)doDrag:(UIGestureRecognizer *)gesture
{

    self.selectedSaladImage.center = [gesture locationInView:self.view];
    FM_Log(@"Frame:%@",NSStringFromCGRect(self.selectedSaladImage.frame));

}

- (void)stopDragging:(UIGestureRecognizer *)gesture
{
    self.selectedSaladImage.center = [gesture locationInView:self.view];

    
    CGRect targetRect = [self.delivertToMe.superview convertRect:self.delivertToMe.bounds toView:self.view];
    if(CGRectContainsPoint(targetRect, self.selectedSaladImage.center)) {
    
        
        [self showAlertWithMessage:@"Success"];
        
        self.selectedSaladImage.hidden = YES;

        [[[FM_SaladManager sharedManager] saladData] addObject:self.salads[self.selectedSaladImage.tag]];
        
        [self updateBasket];
        FM_Log(@"Selected Salad:%@",self.salads[self.selectedSaladImage.tag]);
        
        
    } else {
    
        
        FM_Log(@"Frame:%@",NSStringFromCGRect(self.selectedSaladImage.frame));

        //Reposition the Selected Salad Image
        [UIView animateWithDuration:0.70f animations:^{
            
            CGRect finalFrame = self.selectedSaladImage.frame;
            
            finalFrame.origin.x = self.refPoint.x;
            finalFrame.origin.y = self.refPoint.y;

            self.selectedSaladImage.frame = finalFrame;
            
        } completion:^(BOOL finished) {
            
            self.selectedSaladImage.hidden = YES;
        }];
    }
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deleveryToMe:(id)sender {
}
- (IBAction)deliveryToMeAction:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"push_DeliverToMe" sender:self];
}

- (IBAction)basketBTNAction:(id)sender {
}
@end
