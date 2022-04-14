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

- (void)widgetView:(SSWidgetView *)widgetView onChange:(NSDictionary *)values;

@end

@interface SSWidgetView : UIView

@property (weak, nonatomic) id <SSWidgetViewDelegate> delegate;

- (instancetype)initWithIsDisabledByDefault:(BOOL)isDisabledByDefault;

- (void)updateOrderValue:(NSDecimalNumber *)orderValue;

@end

NS_ASSUME_NONNULL_END
