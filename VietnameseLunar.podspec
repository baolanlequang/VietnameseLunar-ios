Pod::Spec.new do |spec|

  spec.name         = "VietnameseLunar"
  spec.version      = "1.0"
  spec.summary      = "Calculate lunar year in Vietnamese"
  spec.swift_versions   = ['4.0', '5.0', '5.5']
  spec.description  = <<-DESC
                This is library for calculate lunar calendar for Vietnamese
                   DESC

  spec.homepage     = "https://github.com/baolanlequang/VietnameseLunar-ios"

  spec.license      = "MIT"


  spec.author             = { "Lan Le" => "baolan2005@gmail.com" }


  spec.platform     = :ios

  spec.ios.deployment_target = "13.0"

  spec.source       = { :git => "https://github.com/baolanlequang/VietnameseLunar-ios.git", :tag => "#{spec.version}" }

  spec.source_files  = "VietnameseLunar/VietnameseLunar/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"

end
