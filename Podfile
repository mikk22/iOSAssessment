platform :ios, '8.0'
# ignore all warnings from all pods
inhibit_all_warnings!

xcodeproj 'IOSAssessment'

# Add Kiwi as an exclusive dependency for the AmazingAppTests target
target :IOSAssessment, :exclusive => true do
  pod 'AFNetworking', '2.5.4'
  pod 'DCKeyValueObjectMapping', '1.4.0'
  pod 'JTModel',  :path => './JTModel'
#:git => 'https://github.com/mikk22/JTModel.git', :branch => 'master'
  pod 'PureLayout', '2.0.6'
  pod 'SDWebImage', '3.7.1'
end
# Add Kiwi as an exclusive dependency for the AmazingAppTests target
target :IOSAssessmentTests, :exclusive => true do
  pod 'Kiwi', '2.3.1'
end
