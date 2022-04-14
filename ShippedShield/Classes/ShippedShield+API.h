//
//  ShippedShield+API.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedShield.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ShippedShieldFeeHandler)(SSShieldOffers * _Nullable offers, NSError * _Nullable error);

@interface ShippedShield (API)

+ (void)getShieldFee:(NSDecimalNumber *)orderValue completion:(ShippedShieldFeeHandler)completion;

@end

NS_ASSUME_NONNULL_END
