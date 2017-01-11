Pod::Spec.new do |s|
  s.name                  = 'MainWorkSpaceDemo'
  s.version               = '1.0.0'
  s.summary               = 'A new container controller to slide  '
  s.homepage              = 'github.com'
  s.license               = { :type => 'MIT', :file => 'README.md' }
  s.author                = { 'heroims' => 'heroims@163.com' }
  s.source                = { :git => '', :tag => "#{s.version}" }
  s.platform              = :ios, '5.0'
  s.source_files          = 'ZYQRouter/*.{h,m}'
  s.requires_arc          = true
  s.subspec 'BaseTool' do |ss|
    ss.source_files = 'ZYQRouter/*.{h,m}'
  end
  s.subspec 'Module1' do |sss|
    sss.source_files = 'Module1/Module1Lib/*.{h,m}'
  end
  s.subspec 'Module2' do |ssss|
    ssss.source_files = 'Module2/Module2Lib/*.{h,m}'
  end

end
