//
//  HomeViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "HomeViewController.h"

#define kSegue_MakeMySalad @"push_MakeMySalad"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"SaladStacks"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            NSLog(@"Objects:%@",objects);
//            
//            PFQueryCollectionViewController *controller = [[PFQueryCollectionViewController alloc] initWithClassName:@"SaladStacks"];
//            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)controller.collectionViewLayout;
//            flowLayout.itemSize = CGSizeMake(100.0f, 100.0f);
//            [self presentViewController:controller animated:YES completion:nil];
//
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    


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

@end
