//
//  ShippedShield+API.m
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/14.
//

#import "ShippedShield+API.h"
#import "SSNetworking.h"
#import "SSShieldRequest.h"
#import "SSShieldResponse.h"

@implementation ShippedShield (API)

+ (void)getShieldFee:(NSDecimalNumber *)orderValue completion:(ShippedShieldFeeHandler)completion
{
    SSShieldRequest *request = [SSShieldRequest new];
    request.orderValue = orderValue;
    [[SSAPIClient sharedClient] send:request handler:^(SSResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && response && [response isKindOfClass:[SSShieldResponse class]]) {
            SSShieldResponse *shieldResponse = (SSShieldResponse *)response;
            completion(shieldResponse.shieldOffers, error);
        } else {
            completion(nil, error);
        }
    }];
}
@end
