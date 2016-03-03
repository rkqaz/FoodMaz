//
//  FM_SaladStackView.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "FM_SaladStackView.h"
#import "FM_SaladManager.h"



#define kViewFrame CGRectMake(0.0f,4.0f,120.0f, 100.0f)


@implementation FM_SaladStackView

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
        
        [self addTapGesture];

    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self addTapGesture];
    }
    
    return self;
}


- (void)addTapGesture
{

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    singleTap.cancelsTouchesInView = NO;
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];

}

//Gesture selector
- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    
    UIView * v = gesture.view;
    
    //FM_Log(@"Gesture View Class %@",gesture.view.class);
    if ([v isKindOfClass:[FM_SaladStackView class]]) {
        
        
        FM_SaladStackView * stackView = (FM_SaladStackView *)v;
        
        if (stackView.selected) { //<-- if already selected , Deselect
            
            //update selected field
            stackView.selected = !stackView.selected;
            //set selected border color
            stackView.imgView.layer.borderColor = [UIColor orangeColor].CGColor;
            
            //delgate can reponds to selector
            if ( (self.FM_SaladViewDelegate) &&[self.FM_SaladViewDelegate respondsToSelector:@selector(deSelectedStackItem:)]) {
                
                //call callback method
                [self.FM_SaladViewDelegate deSelectedStackItem:stackView.saladStack];
            }

            
        } else { //<-- make selected
        

            if ([[FM_SaladManager sharedManager] salad]) {
                
                //Validation for BED,INGREDIENT,SALAD
                [[[FM_SaladManager sharedManager] salad] validatateSaladStack:stackView.saladStack result:^(BOOL success, NSString *errorMessage) {
                    
                    
                    if(success) { //<--- if validation success
                        
                        //update selected field
                        stackView.selected = !stackView.selected;

                        //set unSelected border color
                        stackView.imgView.layer.borderColor = [UIColor blueColor].CGColor;
                        
                        //delgate can reponds to selector
                        if ( (self.FM_SaladViewDelegate) &&[self.FM_SaladViewDelegate respondsToSelector:@selector(selectedStackItem:)]) {
                            
                            //call callback method
                            [self.FM_SaladViewDelegate selectedStackItem:stackView.saladStack];
                        }
                        
                    } else {
                    
                        if (self.FM_SaladViewDelegate && ([self.FM_SaladViewDelegate respondsToSelector:@selector(errorMessageInPickingSaladStack:)])) {
                        
                            //call callback Method
                            
                            [self.FM_SaladViewDelegate errorMessageInPickingSaladStack:errorMessage];
                        }
                    }
            }];
            
        } else {
            
                  //update selected field

                 stackView.selected = !stackView.selected;

                //set unSelected border color
                stackView.imgView.layer.borderColor = [UIColor blueColor].CGColor;
            
            FM_Salad *salad = [[FM_Salad alloc] init];
            
            salad.customised = YES;
            [salad validatateSaladStack:stackView.saladStack result:^(BOOL success, NSString * _Nonnull errorMessage) {
                
                if (success){
                
                    [[FM_SaladManager sharedManager] setSalad:salad];
                
                    //delgate can reponds to selector
                    if ( (self.FM_SaladViewDelegate) &&[self.FM_SaladViewDelegate respondsToSelector:@selector(selectedStackItem:)]) {
                        
                        //call callback method
                        [self.FM_SaladViewDelegate selectedStackItem:stackView.saladStack];
                    }
                }
            }];
            
            
            
            
            }

        }
        
        
    }
    
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([touch.view isKindOfClass:[FM_SaladStackView class]]) {
        
        return YES;
    }
    return NO;
}


- (void)buildUIWithSaladStack:(FM_SaladStack *)stack
{

    //set dafault value for Sellected filed to NO
    self.selected = NO;
    
    
    if (self.saladStack != stack) {
    
        self.saladStack = stack;
    }

    if (!self.imgView) {
    
        //Add image
        PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 95.0f, 95.0f)];
        // placeholder image
        imageView.image = [UIImage imageNamed:@"..."];
        //set contentmode
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        //set maskstoBounds
        imageView.layer.masksToBounds = YES;
        //set boder width
        imageView.layer.borderWidth = 3.0f;
        //add border color
        imageView.layer.borderColor = [UIColor orangeColor].CGColor;
        //Add corner radius
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame)/2;
        //Add file
        imageView.file = (PFFile *)stack[@"Image"]; // remote image
        //Load Image inBackground
        [imageView loadInBackground];
        //add subview
        [self addSubview:imageView];
    
        self.imgView = imageView;
    }
    /**********$$$$$$$$$$**ADDTITLE**$$$$$$$$$***************/
    //Add title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.frame), 100.0f, 17.0f)];
    //Assaign value
    title.text = stack[@"name"];
    //Alignment
    title.textAlignment = NSTextAlignmentCenter;
    //set font
    [title setFont:[FM_Font labelFont]];
    //text color
    title.textColor = [FM_Color greenColor];
    //add subview
    [self addSubview:title];
    
}
@end
