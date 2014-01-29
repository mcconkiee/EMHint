Pod::Spec.new do |s|
  s.name         = "EMHint"
  s.version      = "1.0"
  s.summary      = "EMHint adds multiple spotlight-like effects to a view  hinting at some things that may be important on the screen."

  s.description  = "EMHint is an iOS class group that easily adds a spotlight-like effect to a view highlighting or hinting at something that may be important on the screen.The protocols of EMHintDelegate allow users to override many of the default actions and views. Tapping the black overlay fades it away. Great for quick "how to" or tutorials in your app"
                   
  s.homepage     = "https://github.com/mcconkiee/EMHint"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Eric McConkie" => "eric@ericmcconkie.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/mcconkiee/EMHint.git",:tag => "1.0"}
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end