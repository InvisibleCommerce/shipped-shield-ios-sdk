//
//  SSLearnMoreViewController.m
//  ShippedShield
//
//  Created by Victor Zhu on 2022/4/8.
//

#import "SSLearnMoreViewController.h"
#import "SSUtils.h"

@interface SSLearnMoreViewController ()

@end

@implementation SSLearnMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = NSLocalizedString(@"Shipped Shield Premium Package Assurance", nil);
    titleLabel.textColor = [UIColor colorWithHex:0x000000];
    titleLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightBold];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    UILabel *subtitleLabel = [UILabel new];
    subtitleLabel.text = NSLocalizedString(@"Have peace of mind and instantly resolve unexpected issues hassle-free.", nil);
    subtitleLabel.textColor = [UIColor colorWithHex:0x000000];
    subtitleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subtitleLabel];
    
    UIView *tipsView = [UIView new];
    tipsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tipsView];
    
    UIView *protectedFirstTipView = [self protectedViewWithText:NSLocalizedString(@"Instant premium package assurance for damage, loss, or theft.", nil)];
    protectedFirstTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedFirstTipView];
    
    UIView *protectedSecondTipView = [self protectedViewWithText:NSLocalizedString(@"Save time and headache reporting unexpected shipment issues.", nil)];
    protectedSecondTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedSecondTipView];
    
    UIView *protectedThirdTipView = [self protectedViewWithText:NSLocalizedString(@"Easily resolve issues and get a replacement or refund, hassle-free.", nil)];
    protectedThirdTipView.translatesAutoresizingMaskIntoConstraints = NO;
    [tipsView addSubview:protectedThirdTipView];
    
    UIView *actionView = [UIView new];
    actionView.backgroundColor = [UIColor colorWithHex:0x13747480];
    actionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:actionView];
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = NSLocalizedString(@"Shipped offers shipment protection with tracking services and hassle-free solutions for resolving shipment issues for online purchases that are damaged in transit, lost by the carrier, or stolen immediately after the carrier’s proof of delivery where Shipped monitors the shipment.", nil);
    descLabel.textColor = [UIColor colorWithHex:0x993c3c43];
    descLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [actionView addSubview:descLabel];
    
    UIButton *closeButton = [UIButton new];
    closeButton.layer.cornerRadius = 10;
    closeButton.layer.masksToBounds = YES;
    closeButton.backgroundColor = [UIColor colorWithHex:0xFFC933];
    [closeButton setTitle:NSLocalizedString(@"Got it!", nil) forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor colorWithHex:0x000000] forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [actionView addSubview:closeButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel, subtitleLabel, tipsView, protectedFirstTipView, protectedSecondTipView, protectedThirdTipView, actionView, descLabel, closeButton);
    
    NSDictionary *metrics = @{@"margin": @16,
                              @"vSpace": @24,
                              @"tipHeight": @40,
                              @"vSectionSpace": @40
    };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[titleLabel]-margin-|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-74-[titleLabel]-vSpace-[subtitleLabel]-vSectionSpace-[tipsView]" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[actionView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tipsView]-vSectionSpace-[actionView]|" options:0 metrics:metrics views:views]];
    
    [tipsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[protectedFirstTipView]-8-|" options:0 metrics:metrics views:views]];
    [tipsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[protectedFirstTipView(tipHeight)]-vSpace-[protectedSecondTipView(tipHeight)]-vSpace-[protectedThirdTipView(tipHeight)]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
    
    [actionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-vSpace-[descLabel]-vSpace-|" options:0 metrics:metrics views:views]];
    [actionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpace-[descLabel]-vSpace-[closeButton(50)]->=0-|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
}

- (UIView *)protectedViewWithText:(NSString *)text
{
    UIView *contentView = [UIView new];
    
    UIImageView *protectedImageView = [UIImageView new];
    NSBundle *sdkBundle = [NSBundle bundleForClass:self.class];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:[sdkBundle pathForResource:@"ShippedShield" ofType:@"bundle"]];
    protectedImageView.image = [UIImage imageNamed:@"protected" inBundle:resourceBundle compatibleWithTraitCollection:nil];
    protectedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:protectedImageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = text;
    titleLabel.textColor = [UIColor colorWithHex:0x000000];
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(protectedImageView, titleLabel);
    
    NSDictionary *metrics = @{@"imageSize": @32,
                              @"hSpace": @12};
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[protectedImageView(imageSize)]-hSpace-[titleLabel]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[protectedImageView(imageSize)]" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    
    return contentView;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
