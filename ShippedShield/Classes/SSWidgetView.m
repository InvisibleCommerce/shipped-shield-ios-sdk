//
//  SSWidgetView.m
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSWidgetView.h"
#import "SSUtils.h"
#import "ShippedShield+API.h"
#import "SSLearnMoreViewController.h"

@interface SSWidgetView ()

@property (nonatomic, strong) UISwitch *shieldSwitch;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *learnMoreButton;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSDecimalNumber *shieldFee;

@end

@implementation SSWidgetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
        [self loadLayoutConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if ([super initWithCoder:coder]) {
        [self loadViews];
        [self loadLayoutConstraints];
    }
    return self;
}

- (void)loadViews
{
    _shieldSwitch = [UISwitch new];
    _shieldSwitch.on = YES;
    [_shieldSwitch addTarget:self action:@selector(shieldStateChanged:) forControlEvents:UIControlEventValueChanged];
    _shieldSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_shieldSwitch];
    
    _containerView = [UIView new];
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_containerView];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = NSLocalizedString(@"Shipped Shield", nil);
    _titleLabel.textColor = [UIColor colorWithHex:0x1A1A1A];
    _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_titleLabel];
    
    NSAttributedString *learnMore = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Learn More", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    
    _learnMoreButton = [UIButton new];
    [_learnMoreButton setAttributedTitle:learnMore forState:UIControlStateNormal];
    [_learnMoreButton setTitleColor:[UIColor colorWithHex:0x4D4D4D] forState:UIControlStateNormal];
    _learnMoreButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    [_learnMoreButton addTarget:self action:@selector(displayLearnMoreModal) forControlEvents:UIControlEventTouchUpInside];
    _learnMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_learnMoreButton];
    
    _feeLabel = [UILabel new];
    _feeLabel.text = NSLocalizedString(@"N/A", nil);
    _feeLabel.textColor = [UIColor colorWithHex:0x1A1A1A];
    _feeLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _feeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_feeLabel];
    
    _descLabel = [UILabel new];
    _descLabel.text = NSLocalizedString(@"Package Assurance for unexpected issues", nil);
    _descLabel.textColor = [UIColor colorWithHex:0x4D4D4D];
    _descLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_descLabel];
}

- (void)loadLayoutConstraints
{
    NSDictionary *views = @{@"shieldSwitch": _shieldSwitch,
                            @"containerView": _containerView,
                            @"titleLabel": _titleLabel,
                            @"learnMoreButton": _learnMoreButton,
                            @"feeLabel": _feeLabel,
                            @"descLabel": _descLabel};
    
    NSDictionary *metrics = @{@"margin": @12,
                              @"hSpace": @8,
                              @"vSpace": @2};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shieldSwitch]-margin-[containerView]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:metrics views:views]];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-hSpace-[learnMoreButton]->=hSpace-[feeLabel]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]-vSpace-[descLabel]|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[feeLabel]-vSpace-[descLabel]|" options:NSLayoutFormatAlignAllRight metrics:metrics views:views]];
}

- (BOOL)isShieldEnabled
{
    return _shieldSwitch.isOn;
}

- (void)setIsShieldEnabled:(BOOL)isShieldEnabled
{
    _shieldSwitch.on = isShieldEnabled;
}

- (void)shieldStateChanged:(id)sender
{
    [self triggerShieldChange];
}

- (void)updateOrderValue:(NSDecimalNumber *)orderValue
{
    __weak __typeof(self)weakSelf = self;
    [ShippedShield getShieldFee:orderValue completion:^(SSShieldOffer * _Nullable offer, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            strongSelf.feeLabel.text = NSLocalizedString(@"N/A", nil);
            strongSelf.shieldFee = NSDecimalNumber.zero;
            NSLog(@"Failed to update shield fee with order value %@", orderValue);
            return;
        }
        
        strongSelf.feeLabel.text = [NSString stringWithFormat:@"$%@", offer.shieldFee.stringValue];
        strongSelf.shieldFee = offer.shieldFee;
        [strongSelf triggerShieldChange];
    }];
}

- (void)triggerShieldChange
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(widgetView:onChange:)]) {
        [self.delegate widgetView:self onChange:@{
            @"isShieldEnabled": @(_shieldSwitch.isOn),
            @"shieldFee": _shieldFee
        }];
    }
}

- (void)displayLearnMoreModal
{
    SSLearnMoreViewController *controller = [[SSLearnMoreViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    if ([UIDevice isIpad]) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        nav.preferredContentSize = CGSizeMake(650, 600);
    }
    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
