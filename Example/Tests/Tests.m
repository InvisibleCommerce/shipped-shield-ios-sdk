//
//  ShippedShieldTests.m
//  ShippedShieldTests
//
//  Created by Victor Zhu on 04/07/2022.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

@import XCTest;
@import ShippedShield;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    [ShippedShield configurePublicKey:@"pk_development_117c2ee46c122fb0ce070fbc984e6a4742040f05a1c73f8a900254a1933a0112"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testShieldFee
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"track test"];
    NSDecimalNumber *orderValue = [NSDecimalNumber decimalNumberWithString:@"129.99"];
    [ShippedShield getShieldFee:orderValue completion:^(SSShieldOffer * _Nullable offer, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(offer.orderValue, orderValue);
        XCTAssertEqualObjects(offer.shieldFee.stringValue, @"2.27");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end

