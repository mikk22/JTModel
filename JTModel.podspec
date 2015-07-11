Pod::Spec.new do |spec|
  spec.name         = "JTModel"
  spec.version      = "0.2"
  spec.summary      = "JTModel is a simple download model container"
  spec.homepage     = "https://github.com/mikk22/JTModel"
  spec.license      = 'none'
  spec.author       = { "Mihail Koltsov" => "mikk.22@gmail.com" }
  spec.platform     = :ios, '6.0'
  spec.source       = { :git => "https://github.com/mikk22/JTModel.git", :tag => spec.version.to_s }
  spec.source_files  = 'Classes/*.{h,m}'
  spec.public_header_files = 'Classes/*.h'
  spec.frameworks    = 'Foundation'
  spec.requires_arc = true
end
