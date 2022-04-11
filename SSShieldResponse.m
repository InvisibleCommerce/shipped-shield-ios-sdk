//
//  SSShieldResponse.m
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/11.
//

#import "SSShieldResponse.h"
#import "SSUtils.h"

@implementation SSShieldOffers

+ (id)decodeFromJSON:(NSDictionary *)json
{
    SSShieldOffers *shieldOffers = [SSShieldOffers new];
    shieldOffers.storefrontId = json[@"storefront_id"];
    NSNumber *orderValue = json[@"order_value"];
    shieldOffers.orderValue = [NSDecimalNumber decimalNumberWithDecimal:orderValue.decimalValue];
    NSNumber *shieldFee = json[@"shield_fee"];
    shieldOffers.shieldFee = [NSDecimalNumber decimalNumberWithDecimal:shieldFee.decimalValue];
    NSString *offeredAt = json[@"offered_at"];
    shieldOffers.offeredAt = [NSDate dateFromString:offeredAt];
    return shieldOffers;
}

@end

@interface SSShieldResponse ()

@property (nonatomic, strong, readwrite) SSShieldOffers *shieldOffers;

@end

@implementation SSShieldResponse

+ (SSShieldResponse *)parse:(NSData *)data
{
    NSError *error = nil;
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    SSShieldResponse *response = [SSShieldResponse new];
    response.shieldOffers = [SSShieldOffers decodeFromJSON:responseObject];
    return response;
}

@end
