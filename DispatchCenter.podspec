#
#  Be sure to run `pod spec lint DispatchCenter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "DispatchCenter"
  s.version      = "1.0.0"
  s.summary      = "A library for solving complex business scheduling, written in Swift"
  s.homepage     = "https://github.com/OnePieceLv/DispatchCenter"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "steven lv" => "steven.suzhou@gmail.com" }
  s.swift_version = "5.0"
  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"
  s.osx.deployment_target = "10.15"
  s.source       = { :git => "https://github.com/OnePieceLv/DispatchCenter.git", :tag => "#{s.version}" }
  s.source_files = "Sources", "Sources/**/*.{h,m,swift}"
  s.framework    = 'UIKit', 'Foundation'
end
