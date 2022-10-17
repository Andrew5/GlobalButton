#
# Be sure to run `pod lib lint GlobalButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'GlobalButton'#跟podspec文件名相同
  spec.version          = '1.0.4'#版本是必须要填的
  spec.summary          = '全局悬浮按钮，方便切换不同的测试环境.'#描述是必填的

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.description      = <<-DESC
                          全局悬浮按钮操作
                       DESC
  spec.homepage         = 'https://github.com/Andrew5/GlobalButton'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { '大海' => 'https://github.com/Andrew5' }
  #使用v前缀的tag值和子模块
  spec.source           = { :git => 'git@github.com:Andrew5/GlobalButton.git', :tag => spec.version.to_s }
#  s.author           = { 'miniLV' => 'https://github.com/miniLV' }
#  s.source           = { :git => 'https://github.com/miniLV/MNFloatBtn.git', :tag => s.version.to_s }
  spec.subspec 'only' do |o|
      o.source_files = "GlobalButton/Classes/DHGlobalConfig.h",
                       "GlobalButton/Classes/DHGlobalConfig.m",
                       "GlobalButton/Classes/DHGlobalContentButton.h",
                       "GlobalButton/Classes/DHGlobalContentButton.m",
                       "GlobalButton/Classes/Unity.h",
                       "GlobalButton/Classes/Unity.m"
      o.public_header_files = 'Classes/DHGlobalConfig.h'
  end
  spec.subspec 'complex' do |c|
      c.source_files = "GlobalButton/Classes/DHGlobeManager.h",
                       "GlobalButton/Classes/DHGlobeManager.m",
                       "GlobalButton/Classes/DHGlobalView.h",
                       "GlobalButton/Classes/DHGlobalView.m",
                       "GlobalButton/Classes/DHHomeDataListView.h",
                       "GlobalButton/Classes/DHHomeDataListView.m"
      c.public_header_files = "GlobalButton/Classes/DHGlobeManager.h"
  end
  spec.default_subspec = 'only'
  spec.ios.deployment_target = '10.0'
# Enable Strict Checking of objc_msgSend Calls   
end
