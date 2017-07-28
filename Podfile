# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ProjectR' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for ProjectR
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
    pod 'GoogleSignIn'
    pod 'PureLayout'
    pod 'Material'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'FBSDKLoginKit'
    pod 'IQKeyboardManagerSwift', '4.0.10'
    
    # Remove modular include warning
    post_install do |installer|
        installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
            configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
        end
    end

end
