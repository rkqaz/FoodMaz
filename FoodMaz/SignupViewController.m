//
//  SignupViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/22/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.signUpButton addTarget:self action:@selector(_signUpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)_signUpBtnAction
{

    PFUser *user = [PFUser user];
    
    [user setUsername:self.userNameTextField.text];
    
    [user setPassword:self.passwordTextField.text];
    
    [user setEmail:self.emailTextField.text];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(error) {
        
            NSLog(@"Error:%@",error.localizedDescription);
            

        } else {
        
            [self performSegueWithIdentifier:@"push_Home" sender:self];

            NSLog(@"User Sucessfully created");
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
