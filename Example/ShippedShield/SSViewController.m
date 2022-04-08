//
//  SSViewController.m
//  ShippedShield
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "SSViewController.h"
#import <ShippedShield/ShippedShield.h>

@interface SSViewController () <SSShieldViewDelegate>

@property (nonatomic, strong) SSShieldView *shieldView;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _shieldView = [[SSShieldView alloc] initWithFrame:CGRectMake(16, 80, CGRectGetWidth(self.view.bounds) - 32, 42)];
    _shieldView.delegate = self;
    [self.view addSubview:_shieldView];
}

- (void)shieldView:(SSShieldView *)shieldView didUpdateShieldState:(BOOL)isOn
{
    NSLog(@"Shield state chagned to %@", isOn ? @"on" : @"off");
}

- (void)shieldView:(SSShieldView *)shieldView didUpdateFeeAmount:(NSDecimalNumber *)feeAmount
{
    
}

@end
