Pod::Spec.new do |s|
  s.name                  = 'Afflato'
  s.version               = '0.1.0'
  s.summary               = 'An event tracking tool for mobile apps.'
  s.homepage              = 'https://afflato.macteo.it'
  s.license               = 'MIT'
  s.authors               = [ 'Matteo Gavagnin' => 'm@macteo.it' ]
  s.social_media_url      = 'https://twitter.com/macteo'
  s.ios.deployment_target = '9.0'
  s.source                = { :git => 'https://github.com/macteo/afflato.git', :tag => "v#{s.version}"}
  s.requires_arc          = true
  # s.frameworks            = [ 'Photos', 'CoreData' ]
  s.default_subspec       = 'Core'
  s.xcconfig              = { 'OTHER_SWIFT_FLAGS' => '$(inherited) -DAFFLATO_AS_COCOAPOD' }

  s.subspec 'Core' do |core|
    core.source_files  = 'Afflato/Core/**/*.swift'
    core.resources     = [ 'Afflato/Core/**/*.xcassets', 'Afflato/Core/*.storyboard']
    core.dependency      'FontAwesome.swift'
  end

  s.subspec 'Debatable' do |debatable|
    debatable.dependency     'Afflato/Core'
    debatable.source_files = 'Afflato/Debatable/**/*.swift'
  end
end
