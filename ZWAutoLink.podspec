Pod::Spec.new do |s|
  s.name         = "ZWAutoLink"
  s.version      = "0.1"
  s.summary      = "URL auto-linking library for Objective-C"

  s.homepage     = "http://github.com/zachwaugh/ZWAutoLink"
  s.license      = 'MIT'
  s.author             = { "Zach Waugh" => "zwaugh@gmail.com" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source       = { :git => "http://github.com/zachwaugh/ZWAutoLink.git", :tag => "0.1" }
  s.source_files  = 'lib'

  s.requires_arc = true
end
