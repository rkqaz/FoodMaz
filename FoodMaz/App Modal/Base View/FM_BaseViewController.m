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
    
    [[UINavigationBar appearance] setBarTintColor:[FM_Color greenColor]];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [UINavigationBar appearance].barTintColor = [FM_Color greenColor];
    
    [[UINavigationBar appearance] setTintColor:[FM_Color greenColor]];

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



- (void)viewDidLoad
{

    [super viewDidLoad];
    
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[FM_Color greenColor]];

    [[UINavigationBar appearance] setTintColor:[FM_Color greenColor]];
}
/*
 * Add Dash border
 */
- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color forFrame:(CGRect) objFrame{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGSize frameSize = CGSizeMake(CGRectGetWidth(objFrame), CGRectGetHeight(objFrame));
    
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

@end
