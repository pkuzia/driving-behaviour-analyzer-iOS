# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

# # Developer Helpers
pod 'SwifterSwift'
pod 'SwiftLint'

# # UI Staff
pod 'Kingfisher', '~> 3.0'
pod 'SwiftSpinner'
pod 'SCLAlertView'

# # DB & Networking
pod 'Realm', '~> 2.1'
pod 'ObjectMapper+Realm'
pod 'Moya-ObjectMapper'
pod 'RealmSwift'
pod 'Moya', '~> 8.0'

# # App Logic

pod 'OBD2-Swift'
pod 'GoogleMaps'

post_install do |installer|
    swift40Targets = ['SwifterSwift', 'SCLAlertView']
	
	installer.pods_project.targets.each do |target|
		if swift40Targets.include? target.name
			target.build_configurations.each do |config|
				config.build_settings['SWIFT_VERSION'] = '4.0'
			end
		end
	end
end
target 'Driving behaviour analyzer' do

end

