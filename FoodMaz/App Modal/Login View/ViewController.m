//
//  ViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/14/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "ViewController.h"

#import "Comms.h"

@interface ViewController ()<CommsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self performSelector:@selector(_loginWithFacebook) withObject:nil afterDelay:1];
    
    //[Comms login:self];
    
    //Add action to Login Button
    [self.loginBtnAction addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    //Add action to Facebook Button
    [self.facebookBtnAction addTarget: self action:@selector(_loginWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    
   }



- (void) commsDidLogin:(BOOL)loggedIn {
    // Re-enable the Login button
    // Did we login successfully ?
    if (loggedIn) {
        // Seque to the Image Wall
        [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
    } else {
        // Show error alert
        [[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                    message:@"Facebook Login failed. Please try again"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - Button action

- (void)_loginWithFacebook {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"email"];
    
  //  FBSDKLoginManager * manager = [PFFacebookUtils facebookLoginManager];
    
//    [[PFFacebookUtils facebookLoginManager] logOut];
    
  //  [PFUser logOut];
    // Login PFUser using Facebook
    [[PFFacebookUtils facebookLoginManager] setLoginBehavior:FBSDKLoginBehaviorNative];
    

    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        //try refreshing the user in case that is the problem (its not, sometimes?).
        [user fetch:&error];

        if (error) {
            FM_Log(@"Error:%@",error.localizedDescription);

        } else {
        
            FM_Log(@"Token:%@",user.sessionToken);
            
            FM_Log(@"UserName:%@",user.username);
            if (!user) {
                FM_Log(@"Uh oh. The user cancelled the Facebook login.");
            } else if (user.isNew) {
                FM_Log(@"User signed up and logged in through Facebook!");
                [self _loadData];

            } else {
                FM_Log(@"User logged in through Facebook!");
                
                [self _loadData];
            }

        }

    }];

//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login logOut];
//    [login logInWithReadPermissions:permissionsArray
//                 fromViewController:self
//                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                                {
//                                    if (error) {
//                                        // Process error
//                                        FM_Log(@"Error:%@",error.localizedDescription);
//                                    } else if (result.isCancelled) {
//                                        // Handle cancellations
//                                        FM_Log(@"User Cancelled");
//                                    } else {
//                                        
//                                        FM_Log(@"Resukt:%@",result.grantedPermissions);
//                                        // If you ask for multiple permissions at once, you
//                                        // should check if specific permissions missing
//                                        if ([result.grantedPermissions containsObject:@"email"]) {
//                                            // Do work
//                                        }
//                                    }
//                                }
//                            }];

}


- (void)loginAction
{

    [self _loginWithFacebook];
    return;
    NSString *userName = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [PFUser logInWithUsernameInBackground:userName password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
        
            FM_Log(@"Error:%@",error.localizedDescription);
        } else {
        
            FM_Log(@"email:%@",user.email);
            FM_Log(@"username:%@",user.username);

        }
    }];
}

-(void)_loadData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location , friends ,hometown , friendlists"}];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            FM_Log(@"Result:%@",result);
            //NSString *facebookID = userData[@"id"];
            PFUser *user = [PFUser currentUser];
            NSString *name = userData[@"name"];

            FM_Log(@"User.Usename:%@",user.username);
            
            FM_Log(@"User.Password:%@",user.password);

           [user setUsername:name];
            
            [user setEmail:result[@"email"]];
            [user setObject:userData[@"email"] forKey:@"email"];
            [user setObject:userData[@"id"] forKey:@"fbID"];

            
            [user saveInBackground];

//            NSString *location = userData[@"location"][@"name"];
//            NSString *gender = userData[@"gender"];
//            NSString *birthday = userData[@"birthday"];
//            NSString *relationship = userData[@"relationship_status"];
//            
//            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
//            
            // Now add the data to the UI elements
            // ...
            
            //RevealView push_Home
            [self performSegueWithIdentifier:@"push_Home" sender:self];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
