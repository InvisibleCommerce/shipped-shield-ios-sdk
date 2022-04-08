//
//  SSShieldView.m
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSShieldView.h"
#import "SSUtils.h"

@interface SSShieldView ()

@property (nonatomic, strong) UISwitch *shieldSwitch;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *learnMoreButton;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation SSShieldView

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
    _learnMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_learnMoreButton];
    
    _feeLabel = [UILabel new];
    _feeLabel.text = @"$0.00";
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
    
    NSDictionary *metrics = @{@"margin": @16,
                              @"hSpace": @8,
                              @"vSpace": @4};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shieldSwitch]-margin-[containerView]|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[shieldSwitch]->=0-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]->=0-|" options:0 metrics:metrics views:views]];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-hSpace-[learnMoreButton]->=0-[feeLabel]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:metrics views:views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]-vSpace-[descLabel]|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[feeLabel]-vSpace-[descLabel]|" options:NSLayoutFormatAlignAllRight metrics:metrics views:views]];
}

- (void)requestToUpdateFee
{
    
}

@end
