//
//  SSShieldResponse.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `SSShieldOffers` includes the details of shield fee.
 */
@interface SSShieldOffers : NSObject <AWXJSONDecodable>

/**
 Storefront id.
 */
@property (nonatomic, copy) NSString *storefrontId;

/**
 Order value.
 */
@property (nonatomic, copy) NSDecimalNumber *orderValue;

/**
 Shield fee.
 */
@property (nonatomic, copy) NSDecimalNumber *shieldFee;

/**
 The date offered at.
 */
@property (nonatomic, copy) NSDate *offeredAt;

@end

/**
 `SSShieldResponse` includes the response of shield fee.
 */
@interface SSShieldResponse : SSResponse

/**
 The shieldOffers object.
 */
@property (nonatomic, readonly) SSShieldOffers *shieldOffers;

@end

NS_ASSUME_NONNULL_END
