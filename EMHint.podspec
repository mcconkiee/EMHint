Pod::Spec.new do |s|
  s.name         = "EMHint"
  s.version      = "1.0"
  s.summary      = "EMHint adds multiple spotlight-like effects to a view  hinting at some things that may be important on the screen."

  s.description  = <<-DESC
                   EMHint was created to help guide users through tutorial like sequences in an easy , fun manner
                   
                   DESC
                   
  s.homepage     = "https://github.com/mcconkiee/EMHint"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Eric McConkie" => "eric@ericmcconkie.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/mcconkiee/EMHint.git",:tag => "1.0" }
  s.source_files = 'HintMakerExample/EMHint.{h,m}'
  s.requires_arc = true
end