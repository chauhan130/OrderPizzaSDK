Pod::Spec.new do |s|
  s.name = 'OrderPizzaSDKCore'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'Pizza ordering core SDK.'
  s.description      = <<-DESC
This is intended to be used across iOS, Mac OS, Watch OS, & TV OS in future.
                       DESC
  s.homepage = 'https://github.com/chauhan130/'
  s.social_media_url = 'http://twitter.com/chauhan130'
  s.authors = { 'Sunil Chauhan' => 'chauhan130@gmail.com' }
  s.source = { :git => 'https://github.com/chauhan130/', :tag => s.version }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*'
end
