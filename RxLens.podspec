Pod::Spec.new do |s|
  s.name             = "RxLens"
  s.version          = "0.1.0"
  s.summary          = "Enables reactive read and copy-on-write access."
  s.description      = <<-DESC
                        Enables reactive read and copy-on-write access for an entity's property in a datastructure.
                        Some examples for lenses can be found in this [blog post](http://chris.eidhof.nl/post/lenses-in-swift/).
                        DESC
  s.homepage         = "https://vknabel.github.io/RxLens"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Valentin Knabel" => "dev@vknabel.com" }
  s.social_media_url = "https://twitter.com/vknabel"
  s.source           = { :git => "https://github.com/vknabel/RxLens.git", :tag => s.version.to_s }
  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true
  s.source_files     = 'Sources/**/*.swift'

  s.dependency 'RxSwift', '~> 3.0'
end
