//
//  SSShieldRequest.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSShieldRequest : SSRequest

@property (nonatomic, copy, nullable) NSDecimalNumber *orderValue;

@end

NS_ASSUME_NONNULL_END
