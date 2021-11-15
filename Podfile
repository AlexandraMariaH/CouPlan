# CouPlan

use_frameworks!
platform :ios, '11.0'

pod 'Firebase/Storage'
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/RemoteConfig'
pod 'FirebaseUI'

pod 'FBSDKLoginKit'
pod 'FacebookSDK'


target 'CouPlan' do

inhibit_all_warnings!

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end

end
