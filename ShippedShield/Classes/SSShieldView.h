//
//  SSShieldView.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSShieldView;
@protocol SSShieldViewDelegate <NSObject>

- (void)shieldView:(SSShieldView *)shieldView didUpdateShieldState:(BOOL)isShieldOn;
- (void)shieldView:(SSShieldView *)shieldView didUpdateShieldFee:(nullable NSDecimalNumber *)shieldFee error:(nullable NSError *)error;

@end

@interface SSShieldView : UIView

@property (weak, nonatomic) id <SSShieldViewDelegate> delegate;

- (void)requestToUpdateShieldFeeWithOrderValue:(NSDecimalNumber *)orderValue;

@end

NS_ASSUME_NONNULL_END
