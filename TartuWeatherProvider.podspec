Pod::Spec.new do |s|
  s.name             = 'TartuWeatherProvider'
  s.version          = '0.4.0'
  s.summary          = 'Tartu weather provider from Tartu Physics faculty'

  s.description      = <<-DESC
Tartu weather provider from Tartu Univerisety Physics faculty. http://meteo.physic.ut.ee/?lang=en
                       DESC

  s.homepage         = 'https://github.com/fassko/TartuWeatherProvider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kristaps Grinbergs' => 'fassko@gmail.com' }
  s.source           = { :git => 'https://github.com/fassko/TartuWeatherProvider.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = "3.0"

  s.source_files = 'Sources/*.swift'

  s.framework = 'Foundation'

  s.dependency 'SwiftSoup', '~> 1.7'
end
