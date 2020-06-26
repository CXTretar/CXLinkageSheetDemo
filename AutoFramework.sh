
#!/bin/bash
#该脚本仅适用于cocoapods生成的framework静态库
frameworkName='CXLinkageSheetView'
#修改
oldversion='0.0.3'
#修改
version='0.0.4'
message=' 增加新的一些属性'

#本地校验
pod lib lint ${frameworkName}.podspec --verbose --use-libraries --allow-warnings
#代码提交到服务器
git add .
git commit -a -m${version}${message}
git tag -a $version -m${message}
git push origin ${version}
git push -u origin master 
#修改version
sed -i '' "s/${oldversion}/${version}/g" ${frameworkName}.podspec

pod trunk push --allow-warnings ${frameworkName}.podspec
