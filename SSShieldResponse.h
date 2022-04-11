//
//  SSShieldResponse.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSShieldOffers : NSObject <AWXJSONDecodable>

@property (nonatomic, copy) NSString *storefrontId;
@property (nonatomic, copy) NSDecimalNumber *orderValue;
@property (nonatomic, copy) NSDecimalNumber *shieldFee;
@property (nonatomic, copy) NSDate *offeredAt;

@end

@interface SSShieldResponse : SSResponse

@property (nonatomic, readonly) SSShieldOffers *shieldOffers;

@end

NS_ASSUME_NONNULL_END
