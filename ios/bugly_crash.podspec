#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'bugly_crash'
  s.version          = '0.0.1'
  s.summary          = 'bugly crash plugin'
  s.description      = <<-DESC
bugly crash plugin
                       DESC
  s.homepage         = 'http://www.tencent.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'tencent' => 'rockypzhang@tencent.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Bugly'
  s.static_framework = true
  s.ios.deployment_target = '8.0'
end

