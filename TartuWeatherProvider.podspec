Pod::Spec.new do |s|
  s.name             = 'TartuWeatherProvider'
  s.version          = '0.1.1'
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

  s.source_files = 'TartuWeatherProvider/Classes/**/*'
  
  s.library = "xml2"
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2', 'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Fuzi/libxml2' }
  
  s.framework = 'Foundation'
  s.framework = 'UIKit'
  
  s.dependency 'Alamofire', '~> 4.2'
  s.dependency 'Fuzi', '~> 1.0'
  s.dependency 'AlamofireImage', '~> 3.2'
end
