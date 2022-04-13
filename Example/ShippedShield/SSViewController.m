//
//  SSViewController.m
//  ShippedShield
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "SSViewController.h"
#import <ShippedShield/ShippedShield.h>

@interface SSViewController () <SSWidgetViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet SSWidgetView *shieldView;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _shieldView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_shieldView updateOrderValue:[[NSDecimalNumber alloc] initWithString:_textField.text]];
}

- (IBAction)viewDidTap:(id)sender
{
    [_textField resignFirstResponder];
}

#pragma mark - SSWidgetViewDelegate

- (void)shieldView:(SSWidgetView *)shieldView onChange:(NSDictionary *)values
{
    NSLog(@"%@", values);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:textField.text];
    if (decimalNumber) {
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                  scale:2
                                                                                       raiseOnExactness:NO
                                                                                        raiseOnOverflow:NO
                                                                                       raiseOnUnderflow:NO
                                                                                    raiseOnDivideByZero:NO];
        
        NSDecimalNumber *roundedNumber = [decimalNumber decimalNumberByRoundingAccordingToBehavior:behavior];
        NSLog(@"Request shield fee for order value %@", roundedNumber.stringValue);
        textField.text = [NSString stringWithFormat:@"%.2f", roundedNumber.doubleValue];
        [_shieldView updateOrderValue:roundedNumber];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid amount" message:@"Please input a valid amount for order value." preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
