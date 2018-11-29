Pod::Spec.new do |s|
  s.name          = "Toolkit"
  s.version       = "1.0.0"
  s.summary       = "Swift toolkit for iOS."
  s.homepage      = "https://github.com/madyanov/iOS-Toolkit"
  s.license       = "MIT"
  s.author        = { "Roman Madyanov" => "romantaken@gmail.com" }
  s.platform      = :ios, "10.3"
  s.source        = { :git => "https://github.com/madyanov/iOS-Toolkit.git", :tag => "#{s.version}" }
  s.source_files  = "Toolkit/**/*"
end
