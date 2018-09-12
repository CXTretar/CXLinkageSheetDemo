#
#  Be sure to run `pod spec lint CXLinkageSheetView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "CXLinkageSheetView"
s.version      = "0.0.1"
s.summary      = "CXLinkageSheetView"

s.description  = <<-DESC

使用 CXLinkageSheetView 可以自定义一个具有横向以及纵向滚动的表格视图控件

DESC

s.homepage     = "https://github.com/CXTretar/CXLinkageSheetDemo"
s.license      = "MIT"

s.author       = { "CXTretar" => "misscxuan@163.com" }

s.platform     = :ios, "8.0"

s.source       = { :git => "https://github.com/CXTretar/CXLinkageSheetDemo.git", :tag => s.version.to_s }

s.source_files  = "CXLinkageSheetDemo/CXLinkageSheetView/*.{h,m}"

s.requires_arc = true

end
