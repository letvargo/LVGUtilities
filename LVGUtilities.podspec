Pod::Spec.new do |s|

  s.name         = "LVGUtilities"
  s.version      = "0.1.2"
  s.summary      = "Basic Swift utility functions."
  s.homepage     = 'https://github.com/letvargo/LVGUtilities'
  s.description  = <<-DESC
A group of basic Swift utility functions for performing the following tasks:

 - C-pointer bridging
                   DESC
  s.license      = 'MIT'
  s.author             = { "Aaron Rasmussen" => "letvargo@gmail.com" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.source       = { :git => "https://github.com/letvargo/LVGUtilities.git", :tag => "0.1.2" }
  s.source_files  = "Source/**/*"
  s.requires_arc = true

  s.subspec 'CBridgingFunctions' do |sp|
    sp.source_files = 'Source/CBridgingFunctions.swift'
  end

  s.subspec 'FourCharCodes' do |sp|
    sp.source_files = 'Source/FourCharCodeUtilities.swift'
  end

  s.subspec 'CodedPropertyType' do |sp|
    sp.source_files = 'Source/CodedPropertyType.swift'
    sp.dependency 'LVGUtilities/FourCharCodes'
  end

  s.subspec 'CodedErrorType' do |sp|
    sp.source_files = 'Source/CodedErrorType.swift'
    sp.dependency 'LVGUtilities/FourCharCodes'
  end

end
