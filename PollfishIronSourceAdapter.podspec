Pod::Spec.new do |s|

    s.name                  = 'PollfishIronSourceAdapter'
    s.version               = '6.4.0.0'
    s.summary               = 'Pollfish iOS Adapter for IronSource Mediation'
    s.module_name           = 'PollfishIronSourceAdapter'
    s.description           = 'Adapter for publishers looking to use IronSource mediation to load and show Rewarded Surveys from Pollfish in the same waterfall with other Rewarded Ads.'
    s.homepage              = 'https://www.pollfish.com/publisher'
    s.documentation_url     = "https://pollfish.com/docs/ios-ironsource-adapter"
    s.license               = { :type => 'Commercial', :text => 'See https://www.pollfish.com/terms/publisher' }
    s.authors               = { 'Pollfish Inc.' => 'support@pollfish.com' }

    s.source                = { :git => 'https://github.com/pollfish/ios-ironsource-adapter.git', :tag => s.version.to_s }
    s.platform              = :ios, '11.0'
    s.static_framework      = true
    s.requires_arc          = true
    s.swift_versions        = ['5.3']

    s.vendored_frameworks   = 'PollfishIronSourceAdapter.xcframework'
    s.dependencies          = { 'Pollfish'=> "~> 6.4.0", 'IronSourceSDK'=> '>= 7.2.5.0'}

    s.pod_target_xcconfig   = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
    
end
