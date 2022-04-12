//
//  SSViewController.m
//  ShippedShield
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "SSViewController.h"
#import <ShippedShield/ShippedShield.h>

@interface SSViewController () <SSShieldViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet SSShieldView *shieldView;

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
    [_shieldView requestToUpdateShieldFeeWithOrderValue:[[NSDecimalNumber alloc] initWithString:@"129.99"]];
}

- (IBAction)viewDidTap:(id)sender
{
    [_textField resignFirstResponder];
}

#pragma mark - SSShieldViewDelegate

- (void)shieldView:(SSShieldView *)shieldView didUpdateShieldState:(BOOL)isShieldOn
{
    NSLog(@"Shield state chagned to %@", isShieldOn ? @"on" : @"off");
}

- (void)shieldView:(SSShieldView *)shieldView didUpdateShieldFee:(nullable NSDecimalNumber *)shieldFee error:(nullable NSError *)error
{
    if (shieldFee) {
        NSLog(@"Shield fee updated to %@", shieldFee.stringValue);
    } else {
        NSLog(@"Shield fee updated failed.\n%@", error.localizedDescription);
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:textField.text];
    if (decimalNumber) {
        NSLog(@"Request shield fee for order value %@", decimalNumber.stringValue);
        [_shieldView requestToUpdateShieldFeeWithOrderValue:decimalNumber];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid amount" message:@"Please input a valid amount for order value." preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
