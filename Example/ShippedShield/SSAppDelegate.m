//
//  SSAppDelegate.m
//  ShippedShield
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

#import "SSAppDelegate.h"
#import <ShippedShield/ShippedShield.h>

@implementation SSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup ShippedShield
    [ShippedShield configurePublicKey:@"pk_development_93da2285385a959eb8df7ee3f7ef521b8d12f6b635e05fea40110afbaa158faa"];
    
    // Optional, the default mode is development mode
    [ShippedShield setMode:ShippedShieldDevelopmentMode];
    
    return YES;
}

@end
