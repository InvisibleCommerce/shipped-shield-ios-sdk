#
# Be sure to run `pod lib lint ShippedShield.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'ShippedShield'
    s.version          = '0.1.4'
    s.summary          = 'Integrate ShippedShield into your iOS app.'
    s.homepage         = 'https://github.com/InvisibleCommerce/shipped-shield-ios-sdk'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = 'Invisible Commerce'
    s.source           = { :git => 'https://github.com/InvisibleCommerce/shipped-shield-ios-sdk.git', :tag => s.version.to_s }
    s.platform         = :ios
    s.ios.deployment_target = '11.0'
    s.source_files     = 'ShippedShield/Classes/**/*'
    s.resource_bundles = {
        'ShippedShield_ShippedShield' => ['ShippedShield/Assets/*.xcassets']
    }
    s.public_header_files = 'ShippedShield/Classes/**/*.h'
    s.frameworks       = 'Foundation', 'UIKit'
end
