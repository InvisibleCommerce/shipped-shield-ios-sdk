//
//  ShippedShieldUnitTest.m
//  ShippedShield_Tests
//
//  Created by Victor Zhu on 2022/5/24.
//  Copyright (c) 2022 Invisible Commerce Limited. All rights reserved.
//

@import XCTest;
@import ShippedShield;

@interface ShippedShieldUnitTest : XCTestCase

@end

@implementation ShippedShieldUnitTest

- (void)setUp
{
    [super setUp];
    [ShippedShield configurePublicKey:@"pk_development_117c2ee46c122fb0ce070fbc984e6a4742040f05a1c73f8a900254a1933a0112"];
}

- (void)testMode
{
    [ShippedShield setMode:ShippedShieldDevelopmentMode];
    XCTAssertEqual([ShippedShield mode], ShippedShieldDevelopmentMode);
    XCTAssertEqualObjects([ShippedShield defaultBaseURL], [NSURL URLWithString:@"https://api-staging.shippedsuite.com/"]);
    [ShippedShield setDefaultBaseURL:[NSURL URLWithString:@"https://api-staging.shippedsuite.com/"]];
}

- (void)testWidgetView
{
    SSWidgetView *widgetView = [[SSWidgetView alloc] initWithFrame:CGRectZero];
    XCTAssertNotNil(widgetView);
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

- (void)testLogger
{
    [SSLogger sharedLogger].enableLogPrinted = YES;
    [[SSLogger sharedLogger] logEvent:@"test"];
    XCTAssertThrows([[SSLogger sharedLogger] logException:@"exception"]);
}

- (void)testUtils
{
    BOOL isIpad = [UIDevice isIpad];
    XCTAssertFalse(isIpad);
    
    UIColor *color = [UIColor colorWithHex:0x000000];
    XCTAssertNotNil(color);
    
    NSDictionary *queryDict = @{@"a": @"b", @"c": @"d"};
    NSString *query = [queryDict queryURLEncoding];
    XCTAssertEqualObjects(query, @"a=b&c=d");
    
    NSString *dateString = @"2022-05-23T23:47:27.738-07:00";
    NSDate *date = [NSDate dateFromString:dateString];
    XCTAssertNotNil(date);
    
    UIEdgeInsets insets = [UIWindow safeAreaInsets];
    XCTAssertTrue(insets.top > 0);
}

- (void)testFailure
{
    [ShippedShield setMode:ShippedShieldProductionMode];
    XCTestExpectation *expectation = [self expectationWithDescription:@"track test"];
    NSDecimalNumber *orderValue = [NSDecimalNumber decimalNumberWithString:@"129.99"];
    [ShippedShield getShieldFee:orderValue completion:^(SSShieldOffer * _Nullable offer, NSError * _Nullable error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
