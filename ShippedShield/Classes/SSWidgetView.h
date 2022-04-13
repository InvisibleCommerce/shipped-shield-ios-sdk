//
//  SSWidgetView.h
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSWidgetView;
@protocol SSWidgetViewDelegate <NSObject>

- (void)shieldView:(SSWidgetView *)shieldView onChange:(NSDictionary *)values;

@end

@interface SSWidgetView : UIView

@property (weak, nonatomic) id <SSWidgetViewDelegate> delegate;

- (void)updateOrderValue:(NSDecimalNumber *)orderValue;

@end

NS_ASSUME_NONNULL_END
