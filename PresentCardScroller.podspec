Pod::Spec.new do |spec|
  spec.name          = 'PresentCardScroller'
  spec.version       = '1.0.0'
  spec.license       = { :type => 'Apache 2.0', :file => "LICENSE" }
  spec.homepage      = 'https://github.com/presentco/PresentCardScroller'
  spec.authors       = { 'Pat Niemeyer' => 'pat@present.co' }
  spec.summary       = 'Card Scrolling UI for iOS.'
  spec.source        = { :git => 'https://github.com/presentco/PresentCardScroller.git', :tag => 'v1.0.0' }
  spec.swift_version = '4.2'

  spec.ios.deployment_target  = '10.0'

  spec.source_files       = 'PresentCardScroller/*.swift'

  spec.framework      = 'SystemConfiguration'
  spec.ios.framework  = 'UIKit'

  spec.dependency 'Then'
  spec.dependency 'TinyConstraints'
end
