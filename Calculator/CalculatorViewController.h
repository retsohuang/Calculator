//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Retso on 7/20/12.
//  Copyright (c) 2012 KeyStoneTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *userPressedHistory;

@end
