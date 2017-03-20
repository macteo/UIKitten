Pod::Spec.new do |s|
  s.name                  = 'UIKitten'
  s.version               = '0.1.0'
  s.summary               = 'Bootstrap your mobile app'
  s.homepage              = 'https://uikitten.macteo.it'
  s.license               = 'MIT'
  s.authors               = ['Matteo Gavagnin' => 'm@macteo.it']
  s.social_media_url      = 'https://twitter.com/macteo'
  s.ios.deployment_target = '9.0'
  s.source                = { git: 'https://github.com/macteo/uikitten.git', tag: "v#{s.version}"}
  s.requires_arc          = true
  # s.frameworks            = [ 'Photos', 'CoreData' ]
  s.default_subspec       = 'Core'
  s.xcconfig              = { 'OTHER_SWIFT_FLAGS' => '$(inherited) -DUIKITTEN_AS_COCOAPOD' }

  s.subspec 'Core' do |core|
    core.source_files  = 'UIKitten/Core/**/*.swift'
    core.resources     = [ 'UIKitten/Core/**/*.xcassets', 'UIKitten/Core/*.storyboard']
    core.dependency      'FontAwesome.swift'
  end

  s.subspec 'Debatable' do |debatable|
    debatable.dependency     'UIKitten/Core'
    debatable.source_files = 'UIKitten/Debatable/**/*.swift'
  end
end