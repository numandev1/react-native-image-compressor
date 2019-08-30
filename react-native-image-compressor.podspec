require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-image-compressor"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-image-compressor
                   DESC
  s.homepage     = "https://github.com/Trunkrs/react-native-image-compressor"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "../LICENSE" }
  s.authors      = { "Trunkrs" => "tech.support@trunkrs.nl" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Trunkrs/react-native-image-compressor.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
	s.dependency 'AFNetworking', '~> 3.0'
  # s.dependency "..."
end

