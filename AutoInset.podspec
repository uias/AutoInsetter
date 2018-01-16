Pod::Spec.new do |s|
  
  s.name         = "AutoInset"
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.version      = "1.0.0"
  s.summary      = "Provide auto insetting capabilities to view controllers."
  s.description  = <<-DESC
            Auto Inset engine that can automatically handle custom insetting of view controllers.
                   DESC

  s.homepage          = "https://github.com/uias/AutoInset"
  s.license           = "MIT"
  s.author            = { "Merrick Sapsford" => "merrick@sapsford.tech" }
  s.social_media_url  = "http://twitter.com/MerrickSapsford"

  s.source       = { :git => "https://github.com/uias/AutoInset.git", :tag => s.version.to_s }
  s.source_files = "Sources/AutoInset/**/*.{h,m,swift}"

end