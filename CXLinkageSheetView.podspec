#
#  Be sure to run `pod spec lint CXLinkageSheetView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "CXLinkageSheetView"
  spec.version      = "0.0.2"
  spec.summary      = "CXLinkageSheetView"


  spec.description  = <<-DESC
  一个同时支持横向和纵向滚动的表格框架控件，适用于一些数据展示页面
                   DESC

  spec.homepage     = "https://github.com/CXTretar/CXLinkageSheetDemo"

  spec.license      = "MIT"

  spec.author             = { "CXTretar" => "misscxuan@163.com" }

  spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/CXTretar/CXLinkageSheetDemo.git", :tag => spec.version.to_s }

  spec.source_files  = "CXLinkageSheetDemo/CXLinkageSheetView/*.{h,m}"
  spec.requires_arc = true
  
end
