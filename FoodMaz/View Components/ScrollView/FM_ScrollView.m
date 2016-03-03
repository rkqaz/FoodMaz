//
//  FM_ScrollView.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_ScrollView.h"

@implementation FM_ScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        //[self constructScroll];
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        //[self constructScroll];
    }
    
    return self;
}


//- (void)constructScroll
//{
//    //Add Tap gesture
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    singleTap.cancelsTouchesInView = NO;
//    singleTap.numberOfTapsRequired = 1;
//   // [self addGestureRecognizer:singleTap];
//
//}
//
//
////Gesture selector
//- (void)handleTap:(UITapGestureRecognizer *)gesture
//{
//
//    UIView * v = gesture.view;
//    
//    FM_Log(@"Gesture View Class %@",gesture.view.class);
//    if ([v isKindOfClass:[FM_SaladStackView class]]) {
//    
//    
//        FM_SaladStackView * stackView = (FM_SaladStackView *)v;
//        
//        stackView.layer.borderColor = [UIColor blueColor].CGColor;
//        
//        //delgate can reponds to selector
//        if ( (self.FM_ScrollDelegate) &&[self.FM_ScrollDelegate respondsToSelector:@selector(selectedStack:)]) {
//        
//          //call callback method
//            [self.FM_ScrollDelegate selectedStack:stackView.saladStack];
//        }
//    }
//    
//}

#pragma mark - UIGestureRecognizer Delegate

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//
//    if ([touch.view isKindOfClass:[FM_SaladStackView class]]) {
//    
//        return YES;
//    }
//    return NO;
//}

#pragma mark - Connvenience Methods

- (void)performLoadWithData:(NSArray *)data

{

    //Check for data
    if (nil != data && data.count > 0) { //<-- if data available download data from Parse
    
        __block float stackView_xpos = 5.0f;
        
         __block float stackView_Width = 100.0f;
        [data enumerateObjectsUsingBlock:^(FM_SaladStack *  _Nonnull stack, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //Prepare frame
            CGRect stackviewFrame = CGRectMake(stackView_xpos, 0.0f, stackView_Width, 100.0f);
            //Add frame
            FM_SaladStackView * stackView = [[FM_SaladStackView alloc] initWithFrame:stackviewFrame];
            //UI for stackView
            [stackView buildUIWithSaladStack:stack];
            //assaign delegate
            stackView.FM_SaladViewDelegate = self;
            //Add to scrollview
            [self addSubview:stackView];
            //Update xPos
            stackView_xpos = stackView_xpos+ stackView_Width + 20.0f;
        }];
        
        //set content size
        [self setContentSize:CGSizeMake(stackView_xpos + stackView_Width, CGRectGetHeight(self.frame))];
        
    } else { //<-- do nothing
    
        //Do Nothing
    }
}


#pragma mark - FM_Stackview Delegate Methods

- (void)selectedStackItem:(FM_SaladStack *)stack

{

    if ( (self.FM_ScrollDelegate) &&[self.FM_ScrollDelegate respondsToSelector:@selector(selectedStack:)]) {
        
        //call callback method
        [self.FM_ScrollDelegate selectedStack:stack];
    }

}

- (void)deSelectedStackItem:(FM_SaladStack *)stack
{

    if ( (self.FM_ScrollDelegate) &&[self.FM_ScrollDelegate respondsToSelector:@selector(deSelectedStack:)]) {
        
        //call callback method
        [self.FM_ScrollDelegate deSelectedStack:stack];
    }
}


- (void)errorMessageInPickingSaladStack:(NSString *)errorMessage
{

    if ( (self.FM_ScrollDelegate) &&[self.FM_ScrollDelegate respondsToSelector:@selector(deSelectedStack:)]) {
        
        //call callback method
        [self.FM_ScrollDelegate errorinPickingStack:errorMessage];
    }
}

@end
