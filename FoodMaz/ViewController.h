//
//  ViewController.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/14/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtnAction;
@property (weak, nonatomic) IBOutlet UIButton *facebookBtnAction;
@end

