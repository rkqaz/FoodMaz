//
//  FM_ScrollView.h
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * FM_ScrollView Delegate
 */
@protocol FM_ScrollViewDelegate <NSObject>

- (void)selectedStack:(FM_SaladStack *)stack;
- (void)deSelectedStack:(FM_SaladStack *)stack;

- (void)errorinPickingStack:(NSString *)error;


//- (void)HSSE_TextFieldDidBeginEditing:(id)textField;
@end

@interface FM_ScrollView : UIScrollView<UIGestureRecognizerDelegate,FM_StackViewDelegate>


@property (assign, nonatomic) id<FM_ScrollViewDelegate> FM_ScrollDelegate;

/*
 * Load Data
 */
- (void)performLoadWithData:(NSArray *)data;
@end
