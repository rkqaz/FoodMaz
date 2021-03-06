//
//  Comms.m
//  FBParse
//
//  Created by Toby Stephens on 14/07/2013.
//  Copyright (c) 2013 Toby Stephens. All rights reserved.
//

#import "Comms.h"

#import <PassKit/PassKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@implementation Comms

+ (void) login:(id<CommsDelegate>)delegate
{
	// Basic User information and your friends are part of the standard permissions
	// so there is no reason to ask for additional permissions
	[PFFacebookUtils logInInBackgroundWithReadPermissions:nil block:^(PFUser *user, NSError *error) {
		// Was login successful ?
		if (!user) {
			if (!error) {
				FM_Log(@"The user cancelled the Facebook login.");
			} else {
				FM_Log(@"An error occurred: %@", error.localizedDescription);
			}
			
			// Callback - login failed
			if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
				[delegate commsDidLogin:NO];
			}
		} else {
			if (user.isNew) {
				FM_Log(@"User signed up and logged in through Facebook!");
			} else {
				FM_Log(@"User logged in through Facebook!");
			}
			
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            [login logInWithReadPermissions:nil
                         fromViewController:[[UIApplication sharedApplication] keyWindow]
                                    handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                        if (error) {
                                            
                                            FM_Log(@"Error :%@",error.localizedDescription);
                                        }
                                        FM_Log(@"Error :%@",error.localizedDescription);
                                    }];
            

//			[FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//				if (!error) {
//					NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
//					// Store the Facebook Id
//					[[PFUser currentUser] setObject:me.id forKey:@"fbId"];
//					[[PFUser currentUser] saveInBackground];
//				}
//				
//				// Callback - login successful
//				if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
//					[delegate commsDidLogin:YES];
//				}
//			}];
		}
	}];
}

//
//+ (void) uploadImage:(UIImage *)image withComment:(NSString *)comment forDelegate:(id<CommsDelegate>)delegate
//{
//    // 1
//    NSData *imageData = UIImagePNGRepresentation(image);
//	
//    // 2
//    PFFile *imageFile = [PFFile fileWithName:@"img" data:imageData];
//    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//			// 3
//            PFObject *wallImageObject = [PFObject objectWithClassName:@"WallImage"];
//            wallImageObject[@"image"] = imageFile;
//            wallImageObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
//            wallImageObject[@"user"] = [PFUser currentUser].username;
//			
//            [wallImageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//					// 4
//					PFObject *wallImageCommentObject = [PFObject objectWithClassName:@"WallImageComment"];
//					wallImageCommentObject[@"comment"] = comment;
//					wallImageCommentObject[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
//					wallImageCommentObject[@"user"] = [PFUser currentUser].username;
//					wallImageCommentObject[@"imageObjectId"] = wallImageObject.objectId;
//					
//					[wallImageCommentObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//						// 5
//						if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
//							[delegate commsUploadImageComplete:YES];
//						}
//					}];
//                } else {
//					// 6
//					if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
//						[delegate commsUploadImageComplete:NO];
//					}
//                }
//            }];
//        } else {
//			// 7
//			if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
//				[delegate commsUploadImageComplete:NO];
//			}
//        }
//    } progressBlock:^(int percentDone) {
//		// 8
//		if ([delegate respondsToSelector:@selector(commsUploadImageProgress:)]) {
//			[delegate commsUploadImageProgress:percentDone];
//		}
//    }];
//}


@end
