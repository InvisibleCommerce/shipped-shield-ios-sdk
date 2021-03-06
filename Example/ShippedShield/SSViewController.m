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
@property (weak, nonatomic) IBOutlet SSWidgetView *widgetView;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _widgetView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_widgetView updateOrderValue:[[NSDecimalNumber alloc] initWithString:_textField.text]];
}

- (IBAction)viewDidTap:(id)sender
{
    [_textField resignFirstResponder];
}

#pragma mark - SSWidgetViewDelegate

- (void)widgetView:(SSWidgetView *)widgetView onChange:(NSDictionary *)values
{
    BOOL isShieldEnabled = [values[SSWidgetViewIsShieldEnabledKey] boolValue];
    NSLog(@"Shield Fee: %@", isShieldEnabled ? @"YES" : @"NO");
    
    NSDecimalNumber *fee = values[SSWidgetViewShieldFeeKey];
    if (fee) {
        NSLog(@"Shield Fee: %@", fee.stringValue);
    }
    
    NSError *error = values[SSWidgetViewErrorKey];
    if (error) {
        NSLog(@"Widget error: %@", error.localizedDescription);
    }
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
        [_widgetView updateOrderValue:roundedNumber];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid amount" message:@"Please input a valid amount for order value." preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Customization

- (IBAction)displayLearnMoreModal:(id)sender
{
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        nav.preferredContentSize = CGSizeMake(650, 600);
    }
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)sendShieldFeeRequest:(id)sender
{
    [ShippedShield getShieldFee:[[NSDecimalNumber alloc] initWithString:_textField.text] completion:^(SSShieldOffer * _Nullable offer, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to get shield fee: %@", error.localizedDescription);
            return;
        }
        
        NSLog(@"Get shield fee: %@", offer.shieldFee.stringValue);
    }];
}

@end
