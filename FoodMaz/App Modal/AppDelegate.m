//
//  AppDelegate.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/14/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "AppDelegate.h"

#define kApplicationId @"0HTeXpHgo34qsgxydAF82LMiwa8Gqd9nZ0YZRxab"

#define kClientKey @"3nbfZj1kKJGT87omY8hSlAJgeKImAVhp3vj8kmoz"

#import <FBSDKCoreKit/FBSDKCoreKit.h>


#import <Parse/Parse.h>

#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // ****************************************************************************
    // Parse initialization
    [Parse setApplicationId:@"0HTeXpHgo34qsgxydAF82LMiwa8Gqd9nZ0YZRxab" clientKey:@"3nbfZj1kKJGT87omY8hSlAJgeKImAVhp3vj8kmoz"];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    // ****************************************************************************
    
    // Track app open.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if (application.applicationIconBadgeNumber != 0) {
        application.applicationIconBadgeNumber = 0;
        [[PFInstallation currentInstallation] saveInBackground];
    }
    
    PFACL *defaultACL = [PFACL ACL];
    // Enable public read access by default, with any newly created PFObjects belonging to the current user
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if ([PFUser currentUser]) {
    
        UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];//RevealView
        
        [self.window setRootViewController:rootViewController];
        
 
    } else {
    
        UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self.window setRootViewController:rootViewController];

    }

    [self.window makeKeyAndVisible];

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
