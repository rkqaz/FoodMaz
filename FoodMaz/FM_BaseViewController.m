//
//  FM_BaseViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/29/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_BaseViewController.h"

@implementation FM_BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    //Notification to show alert
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlertWithMessage:) name:kSHOWALERT_NOTIFICATION object:nil];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    //Remove Notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSHOWALERT_NOTIFICATION object:nil];
    [super viewWillDisappear:animated];
}


- (void)showAlertWithMessage:(NSString*)message
{
    
   // NSDictionary *info = [notification userInfo];
    ///info[k_SHOWALERT_MESSAGE
    //Step 1: Create a UIAlertController
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:message
                                                                               message:nil
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    //Step 2: Create a UIAlertAction that can be added to the alert
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
    [myAlertController addAction: ok];
    
    //Step 4: Present the alert to the user
    [self presentViewController:myAlertController animated:YES completion:nil];
}
@end
