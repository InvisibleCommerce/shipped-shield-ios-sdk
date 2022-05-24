//
//  XCUIElementQuery+Utils.m
//  ShippedShield_ExampleUITests
//
//  Created by Victor Zhu on 2022/5/24.
//  Copyright © 2022 Victor Zhu. All rights reserved.
//

#import "XCUIElementQuery+Utils.h"

@implementation XCUIElementQuery (Utils)

- (XCUIElement *)softMatchingWithSubstring:(NSString *)substring
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label CONTAINS[cd] %@", substring];
    return [self elementMatchingPredicate:predicate].firstMatch;
}

@end
