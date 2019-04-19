Pod::Spec.new do |spec|
  spec.name         = 'KalmanJS'
  spec.version      = '1.0.0'
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '12.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/yanniks/KalmanJS-Swift'
  spec.authors      = 'Wouter Bulten', 'Yannik Ehlert'
  spec.summary      = 'Swift port of KalmanJS'
  spec.source       = { :git => 'https://github.com/yanniks/KalmanJS-Swift.git', :tag => "v#{spec.version}" }
  spec.source_files = 'KalmanJS/*.{h,swift}'
  spec.framework    = 'Foundation'
end
