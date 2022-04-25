//
//  ShippedShield+API.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedShield.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ShippedShieldFeeHandler)(SSShieldOffer * _Nullable offer, NSError * _Nullable error);

@interface ShippedShield (API)

/**
 Get shield fee.
 
 @param orderValue An order value.
 @param completion A handler which includes shield fee..
 */
+ (void)getShieldFee:(NSDecimalNumber *)orderValue completion:(ShippedShieldFeeHandler)completion;

@end

NS_ASSUME_NONNULL_END
