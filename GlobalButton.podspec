#
# Be sure to run `pod lib lint GlobalButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'GlobalButton'#跟podspec文件名相同
  spec.version          = '1.0.0'#版本是必须要填的
  spec.summary          = 'A short description of GlobalButton.'#描述是必填的

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.description      = <<-DESC
                          全局悬浮按钮操作
                       DESC
  spec.homepage         = 'https://github.com/localhost3585@gmail.com/GlobalButton'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'localhost3585@gmail.com' => 'localhost3585@gmail.com' }
  #使用v前缀的tag值和子模块
  spec.source           = { :git => 'https://github.com/localhost3585@gmail.com/GlobalButton.git', :tag => spec.version.to_s }
#  s.author           = { 'miniLV' => 'https://github.com/miniLV' }
#  s.source           = { :git => 'https://github.com/miniLV/MNFloatBtn.git', :tag => s.version.to_s }
  spec.source_files = 'Classes/*.{h,m}'
  spec.public_header_files = 'Classes/DHGlobalConfig.h'
  spec.ios.deployment_target = '9.0'
  spec.source_files = 'GlobalButton/Classes/**/*'
 
end
