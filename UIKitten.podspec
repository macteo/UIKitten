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
  s.default_subspec       = 'Core'

  s.subspec 'Core' do |core|
    core.source_files  = 'UIKitten/Core/**/*.swift'
    core.resources     = [ 'UIKitten/Core/**/*.xcassets', 'UIKitten/Core/*.storyboard']
  end

  s.subspec 'Charts' do |charts|
    charts.dependency     'UIKitten/Core'
    charts.dependency     'Charts'
    charts.source_files = 'UIKitten/Charts/**/*.swift'
  end

  s.subspec 'Icons' do |fontawesome|
    fontawesome.dependency     'UIKitten/Core'
    fontawesome.source_files = 'UIKitten/Icons/**/*.swift'
    fontawesome.dependency     'FontAwesome.swift'
  end
end
