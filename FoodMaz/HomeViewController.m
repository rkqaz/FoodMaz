//
//  HomeViewController.m
//  FoodMaz
//
//  Created by Ravi Kiran on 2/28/16.
//  Copyright © 2016 Ravi Kiran. All rights reserved.
//

#import "HomeViewController.h"

#define kSegue_MakeMySalad @"push_MakeMySalad"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.delivertToMe.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    self.delivertToMe.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    [self.delivertToMe setTitle: @"DELIVER\nTO ME" forState: UIControlStateNormal];
    
    
    
    
    [self _settotalPrice];


}

- (void)_settotalPrice
{

    NSString *priceStr = [NSString stringWithFormat:@"TOTAL\n%i\nAED",[FM_SaladManager sharedManager].saladData.count == 0 ? (int)0 :(int)[[FM_SaladManager sharedManager] price]];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    
    [attributedStr addAttribute:NSFontAttributeName value:[FM_Font labelFontWithSize:25] range:NSMakeRange(0,[attributedStr string].length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[FM_Color greenColor] range:NSMakeRange(0,[attributedStr string].length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[attributedStr string] rangeOfString:@"TOTAL"]];
    
    [attributedStr addAttribute:NSFontAttributeName value:[FM_Font regularFontWithSize:14.0f] range:[[attributedStr string] rangeOfString:@"TOTAL"]];
    [attributedStr addAttribute:NSFontAttributeName value:[FM_Font regularFontWithSize:14.0f] range:[[attributedStr string] rangeOfString:@"AED"]];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[FM_Color greenColor] range:[[attributedStr string] rangeOfString:@"AED"]];
    
    
    self.priceLBL.attributedText = attributedStr;

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

- (IBAction)deleveryToMe:(id)sender {
}
- (IBAction)deliveryToMeAction:(UIButton *)sender {
}

- (IBAction)basketBTNAction:(id)sender {
}
@end
