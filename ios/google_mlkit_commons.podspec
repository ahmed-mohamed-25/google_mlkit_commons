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
   s.platform = :ios, '16.0'
  s.swift_version = '5.9'
  s.static_framework = true

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'VALID_ARCHS' => 'arm64 x86_64'
  }

end
