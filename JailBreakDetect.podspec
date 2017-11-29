Pod::Spec.new do |s|
  s.name             = 'JailBreakDetect'
  s.version          = '0.1.0'
  s.summary          = 'Jailbreak Detection for iOS device, detection work with "xcon" installed!'
  s.description      = 'Jailbreak Detection for iOS device, detection work with "xcon" installed!'
  s.homepage         = 'https://github.com/yuvakumar-phtn/isJB'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yuvakumar-phtn' => 'https://github.com/yuvakumar-phtn' }
  s.source           = { :git => 'https://github.com/yuvakumar-phtn/isJB.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'JailbreakDetection/JBDetect.h', 'JailbreakDetection/JBDetect.m'
end
