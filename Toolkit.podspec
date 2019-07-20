Pod::Spec.new do |s|
  s.name          = "Toolkit"
  s.version       = "1.1.1"
  s.summary       = "Swift toolkit for iOS."
  s.homepage      = "https://github.com/madyanov/iOS-Toolkit"
  s.license       = "MIT"
  s.author        = { "Roman Madyanov" => "romantaken@gmail.com" }
  s.platform      = :ios, "10.0"
  s.source        = { :git => "https://github.com/madyanov/iOS-Toolkit.git", :tag => "v#{s.version}" }
  s.source_files  = "Toolkit/**/*"
end
