Pod::Spec.new do |s|
  s.name = 'OrderPizzaSDK'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'Sample Pizza ordering SDK UI.'
  s.description      = <<-DESC
This framework provides UI to order pizza via OrderPizzaSDKCore.
                       DESC
  s.homepage = 'https://github.com/chauhan130/'
  s.social_media_url = 'http://twitter.com/chauhan130'
  s.authors = { 'Sunil Chauhan' => 'chauhan130@gmail.com' }
  s.source = { :git => 'https://github.com/chauhan130/', :tag => s.version }
  
  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*'
  s.dependency 'OrderPizzaSDKCore'
end
