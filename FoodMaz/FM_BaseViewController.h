//
//  FM_BaseViewController.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/29/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FM_BaseViewController : UIViewController

- (void)showAlertWithMessage:(NSString *)message;

- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color forFrame:(CGRect) objFrame;

@end
