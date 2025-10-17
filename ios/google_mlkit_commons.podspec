require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = library_version
  s.summary          = pubspec['description']
  s.description      = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :file => '../LICENSE' }
  s.authors          = 'Multiple Authors'
  s.source           = { :path => '.' }

  # Source files
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  # Dependencies
  s.dependency 'Flutter'
  s.dependency 'MLKitVision'

  # iOS target & Swift version
  # Raised deployment target and Swift version to align with modern Xcode toolchains (Xcode 26+)
  s.platform = :ios, '17.0'
  s.ios.deployment_target = '17.0'
  s.swift_version = '5.9'
  s.static_framework = true

  # ✅ These three lines are critical for module visibility
  s.requires_arc = true
  s.module_name = 'google_mlkit_commons'
  s.header_dir  = 'google_mlkit_commons'

  # ✅ CocoaPods build settings (for Xcode 16)
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
  'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'NO',
    'CLANG_ENABLE_MODULES' => 'YES',
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    'DEAD_CODE_STRIPPING' => 'NO',
    'IPHONEOS_DEPLOYMENT_TARGET' => '17.0',
    # Exclude arm64 on simulator where required for some CocoaPods/native plugin combinations
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }

  s.user_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
  'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'NO',
    'CLANG_ENABLE_MODULES' => 'YES',
    'IPHONEOS_DEPLOYMENT_TARGET' => '17.0'
  }
end
