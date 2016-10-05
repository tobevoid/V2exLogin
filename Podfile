platform:ios,'9.0'
inhibit_all_warnings!
use_frameworks!

def pods
 	pod 'RxSwift', '~> 3.0.0-beta.1'
   	pod 'RxCocoa', '~> 3.0.0-beta.1'
    pod 'Moya', :git => 'https://github.com/Moya/Moya', :branch => 'swift-3.0'
  	pod 'Moya/RxSwift', :git => 'https://github.com/Moya/Moya', :branch => 'swift-3.0'
    pod 'Locksmith', '~> 3.0.0'
	pod 'Ji', '~> 2.0.0'
    pod 'SnapKit', '~> 3.0.1'
    pod 'YYText', '~> 1.0.7'
    pod 'YYWebImage', '~> 1.0.5'
#    pod 'Realm', '~> 2.0.1'
    pod 'MonkeyKing', '~> 1.0.0'
    pod 'FDFullscreenPopGesture', '~> 1.1'
#    pod 'Quick', '~> 0.10.0'
end

target 'V2exLogin' do
    pods
end

#target 'V2exLoginTests' do
#    pods
#end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            #config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end
