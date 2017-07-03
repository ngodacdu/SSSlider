#
# Be sure to run `pod lib lint SSSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SSSlider'
  s.version          = '1.0.1'
  s.summary          = 'A customisable Slider which will show a tooltip when dragging the slider.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    * A customisable Slider which will show a tooltip when dragging the slider
    * Supported: horizontal, vertical (up and down) orientation
    * Return value with percent unit
                       DESC

  s.homepage         = 'https://github.com/ngodacdu/SSSlider'
  s.screenshots     = 'https://raw.githubusercontent.com/ngodacdu/SSSlider/master/ScreenShot/demo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ngô Đắc Du' => 'ngodacdu92@gmail.com' }
  s.source           = { :git => 'https://github.com/ngodacdu/SSSlider.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SSSlider/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SSSlider' => ['SSSlider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
