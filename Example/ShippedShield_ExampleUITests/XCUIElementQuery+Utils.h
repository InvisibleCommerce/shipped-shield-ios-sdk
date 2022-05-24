//
//  XCUIElementQuery+Utils.h
//  ShippedShield_ExampleUITests
//
//  Created by Victor Zhu on 2022/5/24.
//  Copyright © 2022 Victor Zhu. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUIElementQuery (Utils)

- (XCUIElement *)softMatchingWithSubstring:(NSString *)substring;

@end

NS_ASSUME_NONNULL_END
