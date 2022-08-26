# Migration Guide

### CocoaPods

Replace the line in your `Podfile`:

```ruby
pod 'ShippedShield'
```

With

```ruby
pod 'ShippedSuite'
```

### Carthage

Replace the line in your `Cartfile`

```ogdl
github "InvisibleCommerce/shipped-shield-ios-sdk"
```

With 

```ogdl
github "InvisibleCommerce/shipped-suite-ios-client-sdk"
```

### Swift Package Manager

Remove [Shipped Shield SDK](https://github.com/InvisibleCommerce/shipped-shield-ios-sdk) and add [Shipped Suite SDK](https://github.com/InvisibleCommerce/shipped-suite-ios-client-sdk)

## Setup

Replace

```objective-c
#import <ShippedShield/ShippedShield.h>

[ShippedShield configurePublicKey:@"Public key"];
[ShippedShield setMode:ShippedShieldProductionMode];
```

With

```objective-c
#import <ShippedSuite/ShippedSuite.h>

[ShippedSuite configurePublicKey:@"Public key"];
[ShippedSuite setMode:ShippedSuiteProductionMode];
```

### Create a Shield Widget view

Replace

```objective-c
SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectMake(x, y, width, height)];
widgetView.delegate = self;

[widgetView updateOrderValue:cartValueRoundedNumber];
```

With

```objective-c
SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectMake(x, y, width, height)];
widgetView.type = ShippedSuiteTypeShield;
widgetView.isRespectServer = NO;
widgetView.delegate = self;

[widgetView updateOrderValue:cartValueRoundedNumber];
```

### Customization

- Send the Shield Fee request

Replace

```objective-c
[ShippedShield getShieldFee:[[NSDecimalNumber alloc] initWithString:_textField.text] completion:^(SSShieldOffer * _Nullable offer, NSError * _Nullable error) {
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }

    NSLog(@"Get shield fee: %@", offer.shieldFee.stringValue);
}];
```

With

```objective-c
[ShippedSuite getOffersFee:[[NSDecimalNumber alloc] initWithString:_textField.text] completion:^(SSOffers * _Nullable offers, NSError * _Nullable error) {
    if (error) {
        NSLog(@"Failed to get offers fee: %@", error.localizedDescription);
        return;
    }

    NSLog(@"Get shield fee: %@", offers.shieldFee.stringValue);
    NSLog(@"Get green fee: %@", offers.greenFee.stringValue);
}];
```

- Display learn more modal

Replace

```objective-c
SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithNibName:nil bundle:nil];
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.preferredContentSize = CGSizeMake(650, 600);
}
[self presentViewController:nav animated:YES completion:nil];
```

With

```objective-c
SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithType:ShippedSuiteTypeGreen];
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.preferredContentSize = CGSizeMake(650, 600);
}
[self presentViewController:nav animated:YES completion:nil];
```
